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
      Random.random(5, 20)
    end

    def boulder_grade
      Boulder.grades.keys.sample
    end

    def route_grade
      Route.grades.keys.sample
    end

    def climb_name
      Faker::Hipster.words(rand(4)+1).join
    end
  end
end
