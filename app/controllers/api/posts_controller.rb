class Api::PostsController < ApplicationController
  before_action :ensure_logged_in, except: :show

  def show
    @post = Post.find_by(id: params[:id])

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

  # Deletes post only if author of post is authenticated
  def destroy
    begin 
    @post = Post.find(params[:id])
      if @post && current_user.id == @post.author_id
        @post.destroy
        render json: {}
      end
    rescue StandardError => e
      render json: ["Unable to delete post: #{e.message}"]
    end
  end


  private
    def post_params
      params.require(:post).permit(:title, :body, :id)
    end
end
