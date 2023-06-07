class Api::RatingsController < ApplicationController
  before_action :ensure_logged_in

  def create
    # Checks if a rating already exists by the author for a user. If exists update review if not create new review.
    @rating = Rating.find_by(author_id: current_user.id, rated_user_id: params[:rating][:rated_user_id])

    if @rating
      @rating.update({rating: params[:rating][:rating], author_id: current_user.id, rated_user_id: params[:rating][:rated_user_id]})
    else
      @rating = Rating.new({rating: params[:rating][:rating], author_id: current_user.id, rated_user_id: params[:rating][:rated_user_id]})
    end

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
