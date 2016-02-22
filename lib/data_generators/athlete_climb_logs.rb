class ClimbLogGenerator < BaseGenerator
  def initialize(args = {})
    @min = args[:min] || 0
    @max = args[:max] || 30
  end
end

class AthleteClimbLogGenerator < ClimbLogGenerator
  def initialize(args = {})
    super
    @climb_sesh_generator = args[:climb_sesh_generator] || ClimbSeshGenerator.new
  end

  private
  def define_factory
    # It would be cool if we could use metaprogramming here... could we use method_missing and Binding#local_variable_set? We would need to make that whatever we do, the local variables are still available when the child factory name is computed.
    include_note = include_note?
    include_project = include_project?
    include_quality_rating = include_quality_rating?
    seshes_per_log_min = @climb_sesh_generator.min
    seshes_per_log_max = @climb_sesh_generator.max
    _climb_sesh_factory = @climb_sesh_generator.factory_name

    FactoryManager.define_child_of :athlete_climb_log do
      note { Faker::Hipster.paragraph(1, false, 3) if include_note }
      project { (four_fifths_of_the_time ? true : false) if include_project }
      quality_rating { Faker::Number.between(AthleteClimbLog.min_quality_rating, AthleteClimbLog.max_quality_rating) if include_quality_rating }

      transient do
        climb_seshes_count { Faker::Number.between(seshes_per_log_min, seshes_per_log_max) }
        climb_sesh_factory _climb_sesh_factory
      end
    end
  end

  def include_note?
    a_fifth_of_the_time
  end
  def include_project?
    four_fifths_of_the_time
  end
  def include_quality_rating?
    a_third_of_the_time
  end
end

class SetterClimbLogGenerator < ClimbLogGenerator

end
