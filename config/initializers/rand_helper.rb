class Random
  def self.random(min, max)
    rand(max+1-min) + min
  end
end
