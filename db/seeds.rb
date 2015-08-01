# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = Category.create!([{ name: "ROR" }, { name: "joke" },
   { name: "travel" }, { name: "quotes" }, { name: "politics" }])

chanyu = User.create!({ username: 'chanyu', password: 'j0214ack',
   password_confirmation: 'j0214ack', time_zone: "Taipei"})

posts = Post.create!({ url: 'http://chanyu-tl-postit.herokuapp.com/', title: 'Welcome to Postit!', description:
  "'Post it!' is my practice app, you could check out my github repository about it!",
  user: chanyu, categories: [categories[0]]})
