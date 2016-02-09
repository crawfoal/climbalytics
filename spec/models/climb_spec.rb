require 'rails_helper'

RSpec.describe Climb, type: :model do
  describe 'Validations' do
    #---------------------------------------------------------------------------
    # Validations defined in model
    it { should validate_presence_of :type }
    #---------------------------------------------------------------------------

    it 'should have 1 validator' do
      expect(Climb.validators.size).to be 1
    end
  end

  describe 'Associations' do
    it { should belong_to :loggable }
  end

  context 'which is neither a boulder nor a route' do
    subject(:climb) { build(:climb) }
    it { is_expected.to_not be_valid }
  end
end
