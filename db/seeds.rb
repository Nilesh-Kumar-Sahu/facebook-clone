# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create a main sample user.
User.create!(name:  "Nilesh Kumar",
             email: "nilesh.kumar@gmail.com",
             password:              "qwertyuiop",
             password_confirmation: "qwertyuiop",
             admin: true)

# Generate a bunch of additional users.
35.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "asdfghjkl"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

# Generate posts for a subset of users.
users = User.order(:created_at).take(10)
2.times do
  content = Faker::Lorem.sentence(word_count: 15)
  users.each { |user| user.posts.create!(content: content) }
end