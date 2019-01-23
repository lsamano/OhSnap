class FollowsController < ApplicationController
  def create
    # byebug
    @follow = Follow.create(follow_params)
    redirect_to user_path(@follow.followed)
  end

  def destroy
    @follow = Follow.find(params[:id])
    @unfollowed_user = @follow.followed
    @follow.destroy
    redirect_to user_path(@unfollowed_user)
  end

  private
  def follow_params
    params.require(:follow).permit(:follower_id, :followed_id)
  end
end
