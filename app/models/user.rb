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

  # Returns an array of hashes to be converted to a timeline
  def compile_timeline
    array = []

    # Gather all likes, comments, and posts of people you follow
    self.followeds.each do |followed|
      stuff = followed.posts
      array << stuff
      stuff = followed.likes
      array << stuff
      stuff = followed.comments
      array << stuff
    end
    array.flatten!

    # Order them newest first
    # ordered_objects = array.sort_by(&:created_at)
    # Convert to array of hashes
    array.map! do |instance|
      hash = {}
      if instance.has_attribute?(:contents)
        hash[:action] = "commented on a post"
        hash[:post] = instance.post
        hash[:user] = instance.user
        hash[:created_at] = instance.created_at
      elsif instance.has_attribute?(:caption)
        hash[:action] = "posted a new post"
        hash[:post] = instance
        hash[:user] = instance.user
        hash[:created_at] = instance.created_at
      elsif instance.has_attribute?(:user_id)
        hash[:action] = "liked a post"
        hash[:post] = instance.post
        hash[:user] = instance.user
        hash[:created_at] = instance.created_at
      end
      hash
    end

    array.sort_by { |k| k[:created_at] }.reverse
    # byebug
  end

end
