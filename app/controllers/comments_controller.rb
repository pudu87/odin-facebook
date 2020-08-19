class CommentsController < ApplicationController

  def create
    @comment = Comment.new(post_params)
    @comment.post_id = params[:post_id]
    @comment.user_id = current_user.id
    @comment.save

    redirect_to posts_path
    # TODO: redirect to timeline if on timeline and to userpage if on userpage
  end

  def update
    #TODO
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash.notice = 'Comment deleted'

    redirect_to posts_path
    # TODO: redirect to timeline if on timeline and to userpage if on userpage
  end

  private

  def post_params
    params.require(:comment).permit(:content)
  end

end
