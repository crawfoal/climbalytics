require 'rails_helper'

RSpec.describe Climb, type: :model do
  describe 'Validations' do
    #---------------------------------------------------------------------------
    # Validations defined in model
    it { should validate_presence_of :type }
    #---------------------------------------------------------------------------

    #---------------------------------------------------------------------------
    # Generated validations
    it { should validate_length_of(:name).is_at_most(255) }
    it { should validate_numericality_of(:moves_count).only_integer.allow_nil }
    #---------------------------------------------------------------------------

    it 'should have 3 validators' do
      expect(Climb.validators.size).to be 3
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
