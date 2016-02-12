require 'rails_helper'

RSpec.describe Gym, type: :model do
  subject { create :gym }

  describe 'Validations' do
    #---------------------------------------------------------------------------
    # Validations defined in the model
    it 'should validate validate presence of topo' do
      expect(Gym.create(attributes_for :gym, :no_topo)).to_not be_valid
    end
    #---------------------------------------------------------------------------

    #---------------------------------------------------------------------------
    # Generated validations
    it { should validate_length_of(:name).is_at_most(255) }
    it { should validate_presence_of :name }
    #---------------------------------------------------------------------------

    it 'should have 7 validators' do
      expect(Gym.validators.size).to be 7 # includes validations from CarrierWave for topo column
    end
  end

  describe 'Associations' do
    it { should have_one(:location).dependent(:destroy) }
  end

  it { is_expected.to be_valid }

end
