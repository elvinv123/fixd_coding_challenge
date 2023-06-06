class Api::PostsController < ApplicationController
  before_action :ensure_logged_in

  def show
    @post = Post.find(params[:post][:id])
    if @post
      render :show
    else
      render json: ["Post not found"], status: 404
    end
  end

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
      params.require(:post).permit(:title, :body, :id)
    end
end
