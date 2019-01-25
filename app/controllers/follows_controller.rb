class FollowsController < ApplicationController
  def create
    @follow = Follow.create(follow_params)
    redirect_to user_path(@follow.followed)
  end

  private
  def follow_params
    params.require(:follow).permit(:follower_id, :followed_id)
  end
end
