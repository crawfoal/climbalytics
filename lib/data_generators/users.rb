class UserGenerator < BaseGenerator
  attr_accessor :include_name

  def initialize(args = {})
    @min = args[:min] || 10
    @max = args[:max] || 15
    @include_name = args[:include_name]
  end

  private

  def define_factory
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

  def initialize(args = {})
    super
    @min = args[:min] || 20
    @max = args[:max] || 40
    @alog_generator = args[:alog_generator] || AthleteClimbLogGenerator.new
  end

  private
  def define_factory
    min = @alog_generator.min
    max = @alog_generator.max
    alog_factory = @alog_generator.factory_name

    FactoryManager.define_child_of :athlete do
      transient do
        athlete_climb_logs_count  { Faker::Number.between(min, max) }
        athlete_climb_log_factory alog_factory
      end
    end
  end
end

class SetterGenerator < UserGenerator
  def initialize(args = {})
    super
    @min = args[:min] || 15
    @max = args[:max] || 20
  end

  private
  def define_factory
    :setter
  end
end
