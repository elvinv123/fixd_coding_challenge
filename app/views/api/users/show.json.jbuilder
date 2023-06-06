json.extract! @user, :id, :user_name, :fname, :lname, :avg_rating, :gh_username

json.posts @posts do |post|
  json.partial! '/api/posts/post', post: post
end

json.comments @comments do |comment|
  json.partial! '/api/comments/comment', comment: comment
end

json.github_events @github_events do |event|
  json.id event["id"]
  json.type event["type"]
  json.repo event["repo"]["name"]
  json.payload event["payload"].to_h
end