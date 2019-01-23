class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :liked_users, through: :likes, source: :user
  has_many :commented_users, through: :comments, source: :user
  has_one_attached :image

  #Validations
  validate :image_presence

  ### Methods
  # Validates image is attached
  def image_presence
    errors.add(:image, "Image must be attached.") unless image.attached?
  end

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
