class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comments_params)
    redirect_to post_path(@comment.post)
  end

  private
  def comments_params
    params.require(:comment).permit(:user_id, :post_id, :contents)
  end
end
