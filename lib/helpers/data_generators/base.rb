class BaseGenerator
  attr_accessor :min, :max

  def define_factory_unless_registered
    unless FactoryGirl.factories.registered? factory
      define_factory
    end
  end

  def generate_one
    define_factory_unless_registered
    FactoryGirl.create(factory, *options)
  end

  def generate_set
    Faker::Number.between(min, max).times do
      generate_one
    end
  end

end
