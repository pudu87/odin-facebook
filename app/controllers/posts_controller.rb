class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :edit]

  def index
    @posts = (current_user.posts +
      current_user.confirmed_friends.map{ |f| f.posts }.flatten)
      .sort_by(&:created_at).reverse
      #TODO create a @like-instance to simplify view
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.save
    flash.notice = 'Post created'
    redirect_to user_path(current_user)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    flash.notice = 'Post updated'
    redirect_to user_path(current_user)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash.notice = 'Post deleted'
    redirect_to user_path(current_user)
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

end
