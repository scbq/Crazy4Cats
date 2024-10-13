# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

# Crear usuarios
10.times do
  User.create!(
    email: Faker::Internet.email,
    password: "password",
    password_confirmation: "password"
  )
end

# Crear posts
20.times do
  Post.create!(
    title: Faker::Book.title,
    body: Faker::Lorem.paragraph(sentence_count: 5),
    user_id: User.all.sample.id
  )
end

# Crear comentarios
50.times do
  Comment.create!(
    content: Faker::Lorem.sentence(word_count: 10),
    post_id: Post.all.sample.id,
    user_id: User.all.sample.id
  )
end

puts "¡Base de datos poblada exitosamente!"
