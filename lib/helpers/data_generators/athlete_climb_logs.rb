class ClimbLogGenerator < BaseGenerator

  def initialize(args = {})
    @min = args[:min] || 10
    @max = args[:max] || 30
  end
end

class AthleteClimbLogGenerator < ClimbLogGenerator

end

class SetterClimbLogGenerator < ClimbLogGenerator

end
