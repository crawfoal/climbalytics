# tested via child classes
class BaseGenerator
  attr_accessor :min, :max

  def count=(arg)
    if arg.respond_to? :min and arg.respond_to? :max
      @min = arg.min
      @max = arg.max
    elsif arg.is_a? Integer and arg.respond_to? :to_i
      @min = @max = arg.to_i
    end
  end

  def count
    @min..@max
  end

  def generate_one
    FactoryGirl.create(factory_name, *options)
  end

  def generate_set
    Faker::Number.between(min, max).times do
      generate_one
    end
  end

  def factory_name
    define_factory
  end

  def options
  end

end
