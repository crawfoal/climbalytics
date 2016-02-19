require 'rails_helper'

RSpec.describe Climb, type: :model do
  describe 'Validations' do
    #---------------------------------------------------------------------------
    # Validations defined in model
    it { should validate_presence_of :type }
    it { should validate_numericality_of(:moves_count).is_greater_than(0).only_integer.allow_nil }
    #---------------------------------------------------------------------------

    #---------------------------------------------------------------------------
    # Generated validations
    it { should validate_length_of(:name).is_at_most(255) }
    #---------------------------------------------------------------------------

    it 'should have 3 validators' do
      expect(Climb.validators.size).to be 3
    end
  end

  describe 'Associations' do
    it { should belong_to :loggable }
    it { should belong_to :gym_section }
  end

  context 'which is neither a boulder nor a route' do
    subject(:climb) { build(:climb, type: nil) }
    it { is_expected.to_not be_valid }
  end
end
