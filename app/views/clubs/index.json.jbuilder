json.array!(@clubs) do |club|
  json.extract! club, :id, :name, :webLink, :registrationNumber
  json.url club_url(club, format: :json)
end
