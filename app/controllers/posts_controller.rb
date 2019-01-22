class PostsController < ApplicationController

  def index
    # @posts = Post.all
    # if session[:user_id]
    #   @user = User.find(session[:user_id])
    #   @posts = @user.posts
    # else
    #   @posts = Post.all # or force a login
    # end
    if logged_in?
      @posts = current_user.posts
    else
      @posts = Post.all.reverse # or force a login
    end
  end

  def new
    @post = Post.new
    @users = User.all
    @post_categories = @post.category_names
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    if @post.valid?
      @post.save
      category = Category.find_by(name: params[:post]["category_ids"])
      postcat = PostCategory.find_or_create_by(post: @post, category: category)
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
    @categories = @post.categories
    # byebug
  end

  def edit
    @post = Post.find(params[:id])
    @post_categories = @post.category_names
    @categories = Category.all
  end

  def update
    @post = Post.find(params[:id])
    @post.post_categories.destroy_all
    @post.assign_attributes(post_params)
    if @post.valid?
      @post.save
      category = Category.find_by(name: params[:post]["category_ids"])
      postcat = PostCategory.find_or_create_by(post: @post, category: category)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:caption, :user_id, :image, category_names: [])
  end
end
