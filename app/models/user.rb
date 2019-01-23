class User < ApplicationRecord
  has_secure_password
  has_many :posts
  has_many :comments
  has_many :likes
  has_one_attached :profile_pic
  has_many :liked_posts, through: :likes, source: :post
  has_many :commented_posts, through: :comments, source: :post
end
