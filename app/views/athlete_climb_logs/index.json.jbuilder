json.array!(@athlete_climb_logs) do |athlete_climb_log|
  json.extract! athlete_climb_log, :id, :quality_rating, :note, :project, :athlete_story_id, :setter_climb_log_id
  json.url athlete_climb_log_url(athlete_climb_log, format: :json)
end
