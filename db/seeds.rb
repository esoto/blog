# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create a default user
user = User.where(email: "esoto@gmail.com").first_or_initialize
user.update(
  password: "1234567890",
  password_confirmation: "1234567890"
)

# Mock data 100 BlogPosts
# 100.times do |i|
#   BlogPost.create(
#     title: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4),
#     content: Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 5),
#     published_at: Faker::Date.between(from: 2.days.ago, to: Date.today)
#   )
# end