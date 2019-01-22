class Post < ApplicationRecord
  belongs_to :user
  has_many :post_categories
  has_many :categories, through: :post_categories

  # Custom setter for category names
  def category_names=(names)
    names.each do |name|
      unless name == ""
        category = Category.find_or_create_by(name: name)
        self.categories << category unless self.categories.include?(category)
      end
    end
  end

  # Custom getter for category names
  def category_names
    self.categories.map do |category|
      category.name
    end
  end

end
