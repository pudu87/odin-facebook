class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = Like.new(post_id: params[:post_id], user_id: current_user.id)
    @like.save

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = current_user.likes.find_by_post_id(params[:post_id])
    @like.destroy
    
    redirect_back(fallback_location: root_path)
  end
end
