json.array!(@boulder_logs) do |boulder_log|
  json.extract! boulder_log, :id, :grade, :quality_rating, :note, :project, :athlete_story_id, :boulder_id
  json.url boulder_log_url(boulder_log, format: :json)
end
