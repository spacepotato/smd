json.array!(@comments) do |comment|
  json.extract! comment, :id, :username, :body, :event_id
  json.url comment_url(comment, format: :json)
end
