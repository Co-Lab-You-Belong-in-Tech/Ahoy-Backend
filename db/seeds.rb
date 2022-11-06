# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create([
  { email: 'u1@b.c', password: '123123', name: 'User 1' },
  { email: 'u2@b.c', password: '123123', name: 'User 2' }
])

Room.create(
  name: 'The First room'
)