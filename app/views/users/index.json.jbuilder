json.array!(@users) do |user|
  json.extract! user, :snuid_digest, :anonymous_available_date, :anonymous_nickname, :nickname
  json.url user_url(user, format: :json)
end
