class Api::PostsController < ApplicationController
  before_action :ensure_logged_in

  def create
    @post = Post.new({title: params[:post][:title], body: params[:post][:body], author_id: current_user.id})
    if @post.save
      render :show
    else
      render json: @post.errors.full_messages, status: 422
    end

  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
