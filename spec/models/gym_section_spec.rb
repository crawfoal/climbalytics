require 'rails_helper'

RSpec.describe GymSection, type: :model do
  describe 'Validations' do
    #---------------------------------------------------------------------------
    # Generated validations
    it { should validate_presence_of :name }
    #---------------------------------------------------------------------------

    it 'should have 1 validator' do
      expect(GymSection.validators.size).to be
    end
  end
  describe 'Associations' do
    it { should belong_to :gym }
    it { should have_many(:climbs).conditions(loggable_type: 'SetterClimbLog') }
  end

  subject(:gym_section) { create(:gym_section) }
  it { should be_valid }
end
