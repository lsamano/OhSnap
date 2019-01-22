class LikesController < ApplicationController
  def create
    @like = Like.create(like_params)
    redirect_to post_path(@like.post)
  end

  def destroy
    @like = Like.find(params[:id])
    @post = @like.post
    @like.delete
    redirect_to post_path(@post)
  end

  private
  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
end
