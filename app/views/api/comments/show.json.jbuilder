json.extract! @comment, :id, :body, :author_id, :post_id

json.author do
  json.partial! '/api/users/user', user: @comment.author
end