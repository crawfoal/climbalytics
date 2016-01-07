require 'rails_helper'

describe Role do
  it 'has cached the defined roles upon application start up' do
    expect(Role).to respond_to :defined_roles
  end
  it '.cache_defined_roles and .defined_roles' do
    user = create(:user)
    user.add_role :some_new_role
    expect(Role.defined_roles).to include "some_new_role"
  end
  scenario "the user's current role is set when their first role is assigned" do
    user = create(:user)
    user.add_role :some_new_role
    expect(user.current_role).to eq 'some_new_role'
  end
end
