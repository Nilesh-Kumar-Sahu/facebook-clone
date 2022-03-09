class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.build(comment_params)
    # debugger
    if @comment.save
      flash[:success] = 'Comment created successfully!'
    else
      flash[:warning] = 'There was a error while creating comment!'
    end
    redirect_to request.referer || root_url

  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    return unless @comment

    @comment.delete
    flash[:success] = 'Comment was deleted successfully'
    redirect_to request.referer || root_url
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :content)
  end

  # def fin
  #   @post = current_user.posts.find_by(id: params[:id])
  #   redirect_to root_url if @post.nil?
  # end
end
