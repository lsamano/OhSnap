class User < ApplicationRecord
  has_secure_password
  has_many :posts
  has_many :comments
  has_one_attached :profile_pic
end
