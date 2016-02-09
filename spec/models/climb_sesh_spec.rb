require 'rails_helper'

RSpec.describe ClimbSesh, type: :model do
  describe 'Validations' do
    #---------------------------------------------------------------------------
    # Validations defined in model
    it { should validate_presence_of :athlete_climb_log }
    #---------------------------------------------------------------------------

    it 'should have 1 validator' do
      expect(ClimbSesh.validators.size).to be 1
    end
  end

  subject(:climb_sesh) { build(:climb_sesh) }
  it { should be_valid }

end
