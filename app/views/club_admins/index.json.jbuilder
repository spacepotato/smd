json.array!(@club_admins) do |club_admin|
  json.extract! club_admin, :id
  json.url club_admin_url(club_admin, format: :json)
end
