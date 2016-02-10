require 'rails_helper'

RSpec.describe ClimbSesh, type: :model do
  describe 'Validations' do
    #---------------------------------------------------------------------------
    # Validations defined in model
    it { should validate_presence_of :athlete_climb_log }
    #---------------------------------------------------------------------------

    #---------------------------------------------------------------------------
    # Generated validations
    it { should validate_numericality_of(:high_hold).only_integer.allow_nil }
    it { should validate_length_of(:note).is_at_most(20000) }
    #---------------------------------------------------------------------------

    it 'should have 3 validators' do
      expect(ClimbSesh.validators.size).to be 3
    end
  end

  subject(:climb_sesh) { build(:climb_sesh) }
  it { should be_valid }

end
