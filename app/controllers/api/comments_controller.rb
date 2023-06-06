class Api::CommentsController < ApplicationController
  before_action :ensure_logged_in

  def create
    @comment = Comment.new({author_id: current_user.id, post_id: params[:comment][:post_id], body: params[:comment][:body]})

    if @comment.save
      render :show
    else
      render json: @comment.errors.full_messages, status: 422
    end
  end

  def destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:post_id, :body)
    end
end
