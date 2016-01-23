json.array!(@setter_climb_logs) do |setter_climb_log|
  json.extract! setter_climb_log, :id, :picture
  json.url setter_climb_log_url(setter_climb_log, format: :json)
end
