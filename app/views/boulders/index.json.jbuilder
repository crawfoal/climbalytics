json.array!(@boulders) do |boulder|
  json.extract! boulder, :id, :name, :grade, :picture
  json.url boulder_url(boulder, format: :json)
end
