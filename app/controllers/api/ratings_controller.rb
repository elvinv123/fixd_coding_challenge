class Api::RatingsController < ApplicationController
  before_action :ensure_logged_in

  def create
    @rating = Rating.new({rating: params[:rating][:rating], author_id: current_user.id, rated_user_id: params[:rating][:rated_user_id]})
    if @rating.save
      render :show
    else
      render json: @rating.errors.full_messages, status: 422
    end
  end

  private
  def rating_params
    params.require(:rating).permit(:rating, :rated_user_id)
  end
end
