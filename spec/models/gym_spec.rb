require 'rails_helper'

RSpec.describe Gym, type: :model do
  subject { build :gym }

  describe 'Validations' do
    #---------------------------------------------------------------------------
    # Validations defined in the model
    it 'should validate validate presence of topo' do
      expect(Gym.create(attributes_for :gym, topo: nil)).to_not be_valid
    end
    it { should validate_presence_of :location }
    it { should validate_length_of(:gym_sections) }
    #---------------------------------------------------------------------------

    #---------------------------------------------------------------------------
    # Generated validations
    it { should validate_length_of(:name).is_at_most(255) }
    it { should validate_presence_of :name }
    #---------------------------------------------------------------------------

    it 'should have 8 validators' do
      expect(Gym.validators.size).to be 8 # includes 3 validations from CarrierWave for topo column
    end
  end

  describe 'Associations' do
    it { should have_one(:location).dependent(:destroy) }
    it { should accept_nested_attributes_for :location }

    it { should have_many(:gym_sections).dependent(:destroy) }
    it { should accept_nested_attributes_for(:gym_sections).allow_destroy(true) }
  end

  it { is_expected.to be_valid }

end
