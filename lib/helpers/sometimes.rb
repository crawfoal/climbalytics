module Sometimes

  private

  # I could use metaprogramming here to dynamically generate these methods (or a lot of them). Look into this sometime. But then if I do that stubbing them would be hard or maybe impossible.
  def half_of_the_time
    yield if rand(2) == 0
  end
  def a_third_of_the_time
    yield if rand(3) == 0
  end
  def two_thirds_of_the_time
    yield if rand(3) > 0
  end
  def a_fourth_of_the_time
    yield if rand(4) == 0
  end
  def three_fourths_of_the_time
    yield if rand(4) > 0
  end
  def a_fifth_of_the_time
    yield if rand(5) == 0
  end
  def four_fifths_of_the_time
    yield if rand(5) > 0
  end
end
