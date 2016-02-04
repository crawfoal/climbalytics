module MakeClimbs
  class << self
    def make_boulder(loggable)
      loggable.create_boulder(grade: boulder_grade,
                              moves_count: moves_count,
                              name: climb_name)
    end

    def make_route(loggable)
      loggable.create_route(grade: route_grade,
                            moves_count: moves_count,
                            name: climb_name)
    end

    private

    def moves_count
      a_third_of_the_time { random_between(5, 20) }
    end

    def boulder_grade
      four_fifths_of_the_time { Boulder.grades.keys.sample }
    end

    def route_grade
      four_fifths_of_the_time { Route.grades.keys.sample }
    end

    def climb_name
      a_fifth_of_the_time { Faker::Hipster.words(rand(4)+1).join }
    end
  end
end
