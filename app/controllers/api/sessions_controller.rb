class Api::SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(params[:session][:user_name],params[:session][:password])

    if @user
      login!(@user)
      render json: ["Logged In"], status: 200
    else
      render json: ["Invalid credentials"], status: 401
    end
  end

  def destroy
    if current_user
      logout!
      render json: {}
    else
      render json: ["No user logged in"], status: 404
    end
  end

  private
    def session_params
      params.require(:session).permit(:user_name, :password)
    end
end