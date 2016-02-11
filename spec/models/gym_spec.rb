require 'rails_helper'

RSpec.describe Gym, type: :model do
  describe 'Validations' do
    #---------------------------------------------------------------------------
    # Validations defined in the model
    it { should validate_presence_of(:location) }
    #---------------------------------------------------------------------------

    #---------------------------------------------------------------------------
    # Generated validations
    it { should validate_length_of(:name).is_at_most(255) }
    it { should validate_presence_of :name }
    it { should validate_length_of(:topo).is_at_most(255) }
    it { should validate_presence_of :topo }
    #---------------------------------------------------------------------------

    it 'should have 5 validators' do
      expect(Gym.validators.size).to be 5
    end
  end

  describe 'Associations' do
    it { should have_one(:location).dependent(:destroy) }
  end
end
