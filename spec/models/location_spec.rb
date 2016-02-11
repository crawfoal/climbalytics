require 'rails_helper'

describe Location do
  describe 'Validations' do
    #---------------------------------------------------------------------------
    # Validations defined in model

    #---------------------------------------------------------------------------

    #---------------------------------------------------------------------------
    # Generated validations
    it { should validate_length_of(:name).is_at_most(255) }
    #---------------------------------------------------------------------------

    it 'should have 1 validator' do
      expect(Location.validators.size).to be 1
    end
  end
  
  describe 'Associations' do
    it { should belong_to :locateable }
  end

  context 'with valid attributes' do
    subject(:location) { build(:location) }
    it { should be_valid }
    it 'accepts nested attributes for an address' do
      location = create(:location)
      location.update(address_attributes: attributes_for(:address).merge(state_id: create(:state).id))
      expect(location.address).to be_persisted
    end

    it 'destroys address during destruction' do
      user = create(:location_address).addressable
      expect { user.destroy }.to change { user.address.destroyed? }.from(false).to(true)
    end
  end
end
