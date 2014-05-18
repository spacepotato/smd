json.array!(@messages) do |message|
  json.extract! message, :id, :sender, :receiver, :body
  json.url message_url(message, format: :json)
end
