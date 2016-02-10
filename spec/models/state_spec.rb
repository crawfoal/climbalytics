require 'rails_helper'

describe State do
  describe 'Validations' do
    #---------------------------------------------------------------------------
    # Validations defined in model

    #---------------------------------------------------------------------------

    #---------------------------------------------------------------------------
    # Generated validations
    it { should validate_length_of(:postal_abbreviation).is_at_most(2) }
    it { should validate_length_of(:full_name).is_at_most(50) }
    #---------------------------------------------------------------------------

    it 'should have 2 validator' do
      expect(State.validators.size).to be 2
    end
  end

  context 'with valid attributes' do
    subject(:state) { build(:state) }
    it { should be_valid }
  end
end
