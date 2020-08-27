class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(post_params)
    @comment.post_id = params[:post_id]
    @comment.user_id = current_user.id
    @comment.save

    redirect_back(fallback_location: root_path)
  end

  def update
    #TODO (this needs Javascript)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash.notice = 'Comment deleted'

    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.require(:comment).permit(:content)
  end

end
