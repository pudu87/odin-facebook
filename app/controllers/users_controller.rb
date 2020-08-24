class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.sort_by(&:created_at).reverse
    @post = Post.new
  end
end
