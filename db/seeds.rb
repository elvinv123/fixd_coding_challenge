# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Users
users = User.create([
  { fname: 'John', lname: 'Doe', user_name: 'johndoe', password: 'password1', gh_username: 'johndoe' },
  { fname: 'Jane', lname: 'Smith', user_name: 'janesmith', password: 'password2', gh_username: 'janesmith' },
  { fname: 'David', lname: 'Johnson', user_name: 'davidjohnson', password: 'password3', gh_username: 'davidjohnson' },
])

# Posts
posts = Post.create([
  { title: 'Post 1', body: 'Lorem ipsum dolor sit amet', author: users.first },
  { title: 'Post 2', body: 'Consectetur adipiscing elit', author: users.second },
  { title: 'Post 3', body: 'Sed do eiusmod tempor incididunt', author: users.third },
])

# Comments
comments = Comment.create([
  { body: 'Great post!', author: users.first, post: posts.first },
  { body: 'Nice work!', author: users.second, post: posts.first },
  { body: 'I agree!', author: users.third, post: posts.second },
])

Rating.create({ rating: 5, author: users.first, rated_user: users.second })
Rating.create({ rating: 3, author: users.third, rated_user: users.first })
Rating.create({ rating: 3, author: users.third, rated_user: users.first })