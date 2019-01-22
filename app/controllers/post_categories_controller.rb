class PostCategoriesController < ApplicationController

  private
  def post_category_params
    params.require(:post_category).permit(:category_name, :post_id)
  end
end
