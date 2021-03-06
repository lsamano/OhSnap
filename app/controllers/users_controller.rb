class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    redirect_to posts_path
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @already_following = Follow.find_by(follower_id: current_user.id, followed_id: @user.id)
    @follow = Follow.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.assign_attributes(user_params)
    if @user.valid?
      @user.save
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path
  end

  def follow
    @user = User.find(params[:id])
    @followers = @user.followers
    @followeds = @user.followeds
  end

  private
  def user_params
    params.require(:user).permit(:name, :username, :profile_pic, :password)
  end
end
