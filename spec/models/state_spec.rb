require 'rails_helper'

describe State do
  describe 'Validations' do
    #---------------------------------------------------------------------------
    # Validations defined in model

    #---------------------------------------------------------------------------

    it 'should have no validators' do
      expect(State.validators.size).to be 0
    end
  end

  context 'with valid attributes' do
    subject(:state) { build(:state) }
    it { should be_valid }
  end
end
