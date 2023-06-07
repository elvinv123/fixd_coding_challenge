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

  # Deletes comment only if author of comment is authenticated
  def destroy
    begin 
    @comment = Comment.find(params[:id])
      if @comment && current_user.id == @comment.author_id
        @comment.destroy
        render json: {}
      end
    rescue StandardError => e
      render json: ["Unable to delete comment: #{e.message}"]
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:post_id, :body)
    end
end
