class UserGenerator
  attr_accessor :min, :max, :include_name

  def initialize(args = {})
    @min = args[:min] || 5
    @max = args[:max] || 15
    @include_name = args[:include_name] # not required
  end

  def run
    Faker::Number.between(@min, @max).times do
      FactoryGirl.create(:user, *options)
    end
  end

  private

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
    super(args)
    @min = args[:min] || 20
    @max = args[:max] || 40
  end

  private
  def options
    super + [roles: [:athlete]]
  end
end

class SetterGenerator < UserGenerator
  def initialize(args = {})
    super(args)
    @min = args[:min] || 15
    @max = args[:max] || 20
  end

  private
  def options
    super + [roles: [:setter]]
  end
end
