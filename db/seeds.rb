# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users_list = [
  %w(Rocky Peeters rocky@internet.com),
  %w(Ivan Perisic ivan@internet.com),
  %w(Wagneau Eloi wagneau@internet.com),
  %w(Damir Mirvic damir@internet.com),
  %w(Mama Dissa mama@internet.com),
  %w(Jurgen Sierens jurgen@internet.com)
]

users_list.each do |f,l,e|
  User.create(first_name: f, last_name: l, email: e, password: 'password', password_confirmation: 'password')
end

friendship_list = [
  [1, 2, true],
  [1, 3, true],
  [1, 4, true],
  [1, 5, false],
  [2, 3, true],
  [2, 4, false]
]

friendship_list.each do |u,f,a|
  Friendship.create(user_id: u, friend_id: f, accepted: a)
end