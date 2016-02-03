module RandomExtensions

  private

  def random_between(min, max)
    rand(max+1-min) + min
  end

end
