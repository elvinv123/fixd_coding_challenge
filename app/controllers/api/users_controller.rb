class Api::UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      render :show
    else
      render json: @user.errors.full_messages, status: 422
    end
  end

  def show
    @user = User.find_by(user_name: params[:user_name])
    if @user
      @posts = @user.posts.order(created_at: :desc).page(params[:page])
      @comments = @user.comments.order(created_at: :desc).page(params[:page])
      @github_events = @user.gh_username ? @user.fetch_gh_events : []
      render :show
    else
      render json: ["User not found"], status: 404
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:user_name, :password, :fname, :lname, :gh_username, :page, :per_page)
  end
end
