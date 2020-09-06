# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
50.times do
  project = Project.create(name: Faker::Lorem.word, description: Faker::Lorem.word, created_by: User.first.id)
  project.todos.create(title: Faker::Lorem.word, progress:100)
  project.todos.first.items.create(name: Faker::Lorem.word, done: false, )
end

