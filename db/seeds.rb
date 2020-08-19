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

friendships_list = [
  [1, 2, true],
  [1, 3, true],
  [1, 4, true],
  [1, 5, false],
  [2, 3, true],
  [2, 4, false]
]

friendships_list.each do |u,f,a|
  Friendship.find_or_create_by(user_id: u, friend_id: f, accepted: a)
end

posts_list = [
  [1, 'I scored a hattrick against Lokeren.'],
  [2, 'I won a silver medal in Russia 2018.'],
  [4, 'They call me the Bosnian Wizard.'],
  [6, "Please don't remind me of that own goal against Anderlecht."],
  [2, 'I played for Bayeren Munchen and Inter Milan, but my favourite team will always be Roeselare.']
]

posts_list.each do |u,c|
  Post.find_or_create_by(user_id: u, content: c)
end

comments_list = [
  [3, 1, 'I was there. Rocky I, Rocky II, Rocky III!'],
  [2, 1, 'We could use you in the Croatian team, Rocky.'],
  [1, 1, "I retired already, Ivan. But, let me know if they need a trainer."],
  [3, 2, 'Well done, Ivan.'],
  [3, 2, 'One day we will win that cup with Haiti.']
]

comments_list.each do |u,pt,c|
  Comment.find_or_create_by(user_id: u, post_id: pt, content: c)
end