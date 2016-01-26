require 'rails_helper'

describe Location do
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
