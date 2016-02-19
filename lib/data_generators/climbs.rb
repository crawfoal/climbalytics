class ClimbGenerator < BaseGenerator
  private
  def define_factory
    include_grade = include_grade?
    include_moves_count = include_moves_count?
    include_name = include_name?

    FactoryManager.define_child_of [:boulder, :route].sample do
      grade { type.constantize.grades.keys.sample if include_grade }
      moves_count { Faker::Number.between(1, 30) if include_moves_count }
      name { Faker::Hipster.words(Faker::Number.between(1,5)).join(' ').titlecase if include_name }
    end
  end

  def include_grade?
    four_fifths_of_the_time
  end

  def include_moves_count?
    four_fifths_of_the_time
  end

  def include_name?
    a_fifth_of_the_time
  end
end
