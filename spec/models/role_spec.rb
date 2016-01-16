require 'rails_helper'

describe Role do
  describe '.cache_defined_roles and .defined_roles' do
    it '.define_roles adds the new role to .cache_defined_roles, and .defined_roles uses the cache' do
      define_roles(:some_new_role)
      expect(Role.defined_roles).to include "some_new_role"
    end
  end
  scenario "the user's current role is set when their first role is assigned" do
    define_roles(:some_new_role)
    user = create(:user)
    user.add_role :some_new_role
    expect(user.current_role).to eq 'some_new_role'
  end
end
