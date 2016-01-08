
require 'rails_helper'

describe User do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end
  it 'has a valid athlete factory' do
    define_roles(:athlete)
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
  it 'cannot add a role unless it is already defined' do
    user = create(:user)
    err_msg = user.add_role :undefined_role
    expect(user).to_not have_role :undefined_role
    expect(err_msg).to eq "The role 'undefined_role' was not added for #{user.address_me_as} because the role is not defined."
  end
  it 'cannot grant a role unless it is already defined' do
    user = create(:user)
    err_msg = user.grant :undefined_role
    expect(user).to_not have_role :undefined_role
    expect(err_msg).to eq "The role 'undefined_role' was not added for #{user.address_me_as} because the role is not defined."
  end
  it 'can add a role if it is defined already' do
    define_roles(:defined_role)
    user = create(:user)
    user.add_role :defined_role
    expect(user).to have_role :defined_role
  end
  context 'user has a first name defined' do
    it '#address_me_as' do
      name = create(:name)
      user = name.user
      expect(user.address_me_as).to eq name.first
    end
  end
  context 'user does not has a first name defined' do
    it '#address_me_as' do
      user = create(:user)
      expect(user.address_me_as).to eq user.email
    end
  end

end
