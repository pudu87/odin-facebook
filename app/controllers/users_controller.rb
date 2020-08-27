class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]

  def index
    @users = User.all
    #TODO: show invitation requests at the top
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.sort_by(&:created_at).reverse
    @post = Post.new
  end

  def edit_name
    @user = User.find(params[:id])
  end

  def update_name
    @user = User.find(params[:id])
    @user.update(name_params)
    flash.notice = 'Name successfully changed.'
    redirect_to user_path(current_user)
  end

  private

  def name_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
