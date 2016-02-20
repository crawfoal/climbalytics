class GymGenerator < BaseGenerator
  def initialize(args = {})
    @min = args[:min] || 5
    @max = args[:max] || 10
  end
  private
  def define_factory
    _num_sections = num_sections
    FactoryManager.define_child_of :gym do
      after(:create) do |gym|
        _num_sections.times { gym.sections << create(:gym_section) }
      end
    end
  end
  def num_sections
    Faker::Number.between(0,5)
  end
end
