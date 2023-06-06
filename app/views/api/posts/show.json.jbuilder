json.extract! @post, :id, :title, :body, :created_at

json.author do
  json.partial! '/api/users/user', user: @post.author
end

json.comments @post.comments do |comment|
  json.partial! '/api/comments/comment', comment: comment
end