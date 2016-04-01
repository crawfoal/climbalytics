require 'main_suite_helper'

RSpec.describe GymSection, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
  end
  describe 'Associations' do
    it { should belong_to :gym }
    it { should have_many(:climbs).conditions(loggable_type: 'SetterClimbLog') }
  end

  subject(:gym_section) { build(:gym_section) }
  it { should be_valid }
end
