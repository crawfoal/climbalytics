
require 'rails_helper'

describe User do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end
  it 'has a valid athlete factory' do
    athlete = create(:athlete_user)
    expect(athlete).to be_valid
    expect(athlete).to have_role :athlete
  end
  it 'accepts nested attributes for a name' do
    user = create(:user)
    user.update(name_attributes: attributes_for(:name))
    expect(user.name).to be_persisted
  end
  it 'accepts nested attributes for an address' do
    user = create(:user)
    user.update(address_attributes: attributes_for(:address).merge(state_id: create(:state).id))
    expect(user.address).to be_persisted
  end
  it 'destroys address during destruction' do
    user = create(:user_address).addressable
    user.destroy
    expect(user.address).to be_destroyed
  end
  describe User::Name do
    it 'has a valid factory' do
      expect(build(:name)).to be_valid
    end
    it 'is destroyed when user is destroyed' do
      user = create(:name).user
      user.destroy
      expect(user.name).to be_destroyed
    end
  end

end
