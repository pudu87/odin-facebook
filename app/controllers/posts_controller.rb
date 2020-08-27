class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = (current_user.posts +
      current_user.confirmed_friends.map{ |f| f.posts }.flatten)
      .sort_by(&:created_at).reverse
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.save
    flash.notice = 'Post created'
    redirect_back(fallback_location: root_path)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    flash.notice = 'Post updated'
    redirect_to root_path
    #TODO: return to previous path
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash.notice = 'Post deleted'
    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.require(:post).permit(:content, :photo)
  end

end
