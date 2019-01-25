class CategoriesController < ApplicationController
  add_breadcrumb "home", :feed_path
  def index
    @categories = Category.all
    add_breadcrumb "index", categories_path
  end

  def show
    @category = Category.find(params[:id])
    @posts = @category.posts.reverse
  end
end
