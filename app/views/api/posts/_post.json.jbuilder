json.id post.id
json.title post.title
json.body post.body
json.created_at post.created_at
json.author do
  json.partial! '/api/users/user', user: post.author
end
