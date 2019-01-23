class User < ApplicationRecord
  has_secure_password
  has_many :posts
  has_many :comments
  has_many :likes
  has_one_attached :profile_pic
  has_many :liked_posts, through: :likes, source: :post
  has_many :commented_posts, through: :comments, source: :post

  has_many :follows

  # :following_follows = The follow that you are giving to someone else
  # :class_name = The actual name of the class to be searched
  # :foreign_key = The actual foreign_key on the table to be compared to a User's id
  has_many :following_follows, class_name: "Follow", foreign_key: :follower_id
  has_many :followeds, through: :following_follows, source: :followed

  ##############################
  has_many :followed_follows, class_name: "Follow", foreign_key: :followed_id
  has_many :followers, through: :followed_follows, source: :follower

end
