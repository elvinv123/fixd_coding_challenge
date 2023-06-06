json.id comment.id
json.body comment.body
json.created_at comment.created_at
json.author do
  json.partial! '/api/users/user', user: comment.author
end

