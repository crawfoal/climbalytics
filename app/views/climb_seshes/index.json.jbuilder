json.array!(@climb_seshes) do |climb_sesh|
  json.extract! climb_sesh, :id, :high_hold, :note, :athlete_climb_log_id
  json.url climb_sesh_url(climb_sesh, format: :json)
end
