# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
  User.destroy_all
  Category.destroy_all
  Post.destroy_all

  Category.create(name:"Inspirational Quotes")
  Category.create(name:"Portraits")
  Category.create(name:"Landscape")
  Category.create(name:"Scenery")
  Category.create(name:"Food")
  Category.create(name:"Animals")
  Category.create(name:"Historical")
  Category.create(name:"Travel")
  Category.create(name:"DIY & Crafts")
  Category.create(name:"Fashion")
  Category.create(name:"Home Decor")
  Category.create(name:"Technology")
  Category.create(name:"Celebration")



  require 'open-uri'

new_users = []

7.times do |n|
  s = User.create(
     username: Faker::Pokemon.unique.name,
     name: Faker::Name.name,
     password_digest: BCrypt::Password.create('abc')
  )
  s.profile_pic.attach({
     io: open("https://loremflickr.com/300/300"),
     filename: "#{n}_faker_image.jpg"
  })
  new_users << s
end

  10.times do |time|
    post = Post.new(caption: Faker::Lorem.sentence, user: new_users.sample)
    post.image.attach({
       io: open("http://lorempixel.com/300/300"),
       filename: "post_#{post.id}_faker_image.jpg"
    })
    post.save
    number = rand(1..3)
    cats = Category.all.sample(number)
      cats.each do |cat|
        PostCategory.create(post: post, category: cat)
      end
  end

18.times do |time|
  Like.create(user: new_users.sample, post: Post.all.sample)
  Follow.create(follower: new_users.sample, followed: new_users.sample)
end

15.times do |time|
  post = Post.new(caption: Faker::Lorem.sentence, user: new_users.sample)
  post.image.attach({
     io: open("http://lorempixel.com/300/300"),
     filename: "post_#{post.id}_faker_image.jpg"
  })
  post.save
  number = rand(1..3)
  cats = Category.all.sample(number)
    cats.each do |cat|
      PostCategory.create(post: post, category: cat)
    end

    Like.create(user: new_users.sample, post: Post.all.sample)
    Follow.create(follower: new_users.sample, followed: new_users.sample)
end

60.times do |time|
  Comment.create(user: new_users.sample, post: Post.all.sample, contents: Faker::Lorem.sentence(2))
end
