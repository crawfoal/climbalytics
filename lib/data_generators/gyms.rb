class GymGenerator < BaseGenerator
  def initialize(args = {})
    @min = args[:min] || 5
    @max = args[:max] || 10
    @location_generator = LocationGenerator.new
  end
  private
  def define_factory
    _num_sections = num_sections
    _location_factory = @location_generator.factory_name
    FactoryManager.define_child_of :gym do
      transient do
        location_factory _location_factory
      end
      after(:create) do |gym|
        _num_sections.times { gym.sections << create(:gym_section) }
      end
    end
  end
  def num_sections
    Faker::Number.between(1,5)
  end
end
