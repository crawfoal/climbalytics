# tested via child classes
# > but I should still test this by itself - I can create "minimum requirement" child class in the spec and test these method via that guy
class BaseGenerator
  attr_accessor :min, :max

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
