json.array!(@gyms) do |gym|
  json.extract! gym, :id, :name, :topo
  json.url gym_url(gym, format: :json)
end
