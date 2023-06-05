class Api::SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(params[:user_name],params[:password])

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
end