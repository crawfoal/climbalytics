require 'rails_helper'

describe Location do
  it 'has a valid factory' do
    expect(build(:location)).to be_valid
  end
  it 'accepts nested attributes for an address' do
    location = create(:location)
    location.update(address_attributes: attributes_for(:address).merge(state_id: create(:state).id))
    expect(location.address).to be_persisted
  end
  it 'destroys address during destruction' do
    user = create(:location_address).addressable
    user.destroy
    expect(user.address).to be_destroyed
  end
end
