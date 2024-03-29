# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'date'  # seem to not need it when creating demo user's birthday

User.destroy_all
Post.destroy_all
Comment.destroy_all
Like.destroy_all
Friendship.destroy_all

puts '🌱🌱🌱 Seeding users... 🌱🌱🌱'
puts '🌱🌱🌱 Seeding posts... 🌱🌱🌱'
puts '🌱🌱🌱 Seeding comments... 🌱🌱🌱'
puts '🌱🌱🌱 Seeding friendships... 🌱🌱🌱'

# create demo user
User.create(
  first_name: 'James',
  last_name: 'Jani',
  email: 'JamesJani@gmail.com',
  password: 'password',
  gender: 'Male',
  birthday: Date.new(2000, 1, 1)
)

# create 10 random users
10.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'password',
    gender: Faker::Gender.binary_type,
    birthday: Faker::Date.birthday(min_age: 16, max_age: 100)
  )
end

# create 10 random posts on each user's wall with random authors
User.all.each do |user|
  10.times do
    Post.create(
      author_id: User.all.map { |u| u.id }.sample,
      body: Faker::Quote.famous_last_words,
      recipient_id: user.id
    )
  end
end

# create 10 random comments for each post with random authors
Post.all.each do |post|
  10.times do
    Comment.create(
      author_id: User.all.map { |u| u.id }.sample,
      post_id: post.id,
      body: Faker::Quote.famous_last_words
    )
  end
end

# create 16 random friendships
while Friendship.all.length < 16
  possible_user_ids = User.all.map { |u| u.id }
  user_id = possible_user_ids.sample

  possible_friend_ids = possible_user_ids[0..-1]
  possible_friend_ids.delete(user_id)
  friend_id = possible_friend_ids.sample

  if !(Friendship.find_by(user_id: user_id, friend_id: friend_id))
    Friendship.create(user_id: user_id, friend_id: friend_id)
  end

  if !(Friendship.find_by(user_id: friend_id, friend_id: user_id))
    Friendship.create(user_id: friend_id, friend_id: user_id)
  end

  user = User.find(user_id)
  if !(user.friends_list.split(',').include?(friend_id.to_s))
    user.friends_list = user.friends_list.split(',').push(friend_id).join(',')
    user.save
  end

  friend = User.find(friend_id)
  if !(friend.friends_list.split(',').include?(user_id.to_s))
    friend.friends_list = friend.friends_list.split(',').push(user_id).join(',')
    friend.save
  end
end