class LikesController < ApplicationController

  def create
    @like = Like.new(post_id: params[:post_id], user_id: current_user.id)
    @like.save

    redirect_to root_path
    # TODO: redirect to timeline if on timeline and to userpage if on userpage
  end

  def destroy
    @like = current_user.likes.find_by_post_id(params[:post_id])
    @like.destroy
    
    redirect_to root_path
    # TODO: redirect to timeline if on timeline and to userpage if on userpage
  end

end
