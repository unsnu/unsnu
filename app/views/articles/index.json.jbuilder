json.array!(@articles) do |article|
  json.extract! article, :title, :nickname, :content, :upvote, :downvote, :comment_count, :locked?, :view_count
  json.url article_url(article, format: :json)
end
