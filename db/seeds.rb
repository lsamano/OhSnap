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

5.times do |n|
  s = User.create(
     username: Faker::Pokemon.name,
     name: Faker::Name.name,
     password_digest: BCrypt::Password.create('abc')
  )
  s.profile_pic.attach({
     io: open("https://robohash.org/#{Faker::Lorem.characters(10)}?set=set4"),
     filename: "#{n}_faker_image.jpg"
  })
end

User.all.each do |user|
  2.times do |time|
    post = Post.new(caption: Faker::Lorem.sentence, user: user)
    post.image.attach({
       io: open("http://loremflickr.com/300/300"),
       filename: "post_#{post.id}_faker_image.jpg"
    })
    post.save
  end
end
