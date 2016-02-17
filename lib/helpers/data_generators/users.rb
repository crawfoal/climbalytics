class UserGenerator < BaseGenerator
  attr_accessor :include_name

  def initialize(args = {})
    @min = args[:min] || 5
    @max = args[:max] || 15
    @include_name = args[:include_name] # not required
  end

  private

  def factory
    :user
  end

  def options
    [(:with_name if include_name?)]
  end

  def include_name?
    case @include_name
    when :never
      false
    when :always
      true
    else
      [true, false].sample
    end
  end
end

class AthleteGenerator < UserGenerator
  attr_reader :athlete_climb_log_generator

  def initialize(args = {})
    super(args)
    @min = args[:min] || 20
    @max = args[:max] || 40
    @athlete_climb_log_generator = AthleteClimbLogGenerator.new
  end

  private
  def factory
    :_athlete
  end

  def define_factory
    min = athlete_climb_log_generator.min
    max = athlete_climb_log_generator.max
    FactoryGirl.define do
      factory :_athlete, parent: :athlete do
        transient do
          athlete_climb_logs_count { Faker::Number.between(min, max) }
        end
      end
    end
  end
end

class SetterGenerator < UserGenerator
  def initialize(args = {})
    super(args)
    @min = args[:min] || 15
    @max = args[:max] || 20
  end

  private
  def factory
    :setter
  end
end
