json.array!(@comments) do |comment|
  json.extract! comment, :nickname, :content, :has_children?, :parent_id, :cascade_level
  json.url comment_url(comment, format: :json)
end
