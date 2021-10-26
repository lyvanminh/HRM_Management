# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# 
# Create data table roles
Role.delete_all
roles = ["Manager", "HR Manager", "Sale Manager", "CEO", "HR Department", "Project Manager", "General Manager", "Technical Manager", "Project Leader", "Customer"]
arr = []
roles.each do |role|
  arr << {
    role: role
  }
end

Role.import arr, validate: true

# Create data table users
User.delete_all
roles = Role.all
roles.each do |role|
  User.create!(email: Faker::Internet.email,
               name: Faker::Name.name,
               phone_number: "0336896191",
               birthday: Faker::Date.between(from: 40.years.ago, to: 20.years.ago),
               role_id: role.id,
               password: "12345678")
end

# Create data table languages
Language.delete_all
languages = ["Ruby", "PHP", "Golang", "Python", "React Native", "React JS", "Vuejs", "Nodejs"]
arr = []
languages.times do |language|
  arr << {
    language: language,
    description: Faker::Lorem.paragraphs
  }
end
Language.import arr, validate: true
