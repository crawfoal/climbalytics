class ClimbSeshGenerator < BaseGenerator
  def initialize(args = {})
    @min = args[:min] || 1
    @max = args[:max] || 10
  end

  private
  def define_factory
    include_high_hold = include_high_hold?
    include_note = include_note?

    FactoryManager.define_child_of :climb_sesh do
      high_hold { Faker::Number.between(0,30) if include_high_hold }
      note { Faker::Hipster.paragraph(1, false, 3) if include_note }
    end
  end

  def include_high_hold?
    four_fifths_of_the_time
  end

  def include_note?
    a_fifth_of_the_time
  end
end
