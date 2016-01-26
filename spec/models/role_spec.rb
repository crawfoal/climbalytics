require 'rails_helper'

describe Role do
  before :each do
    define_roles(:some_new_role)
  end
  describe '.cache_defined_roles and .defined_roles' do
    it '.define_roles adds the new role to .cache_defined_roles, and .defined_roles uses the cache' do
      expect(Role.defined_roles).to include "some_new_role"
    end
  end
  scenario "the user's current role is set when their first role is assigned" do
    user = create(:user)
    expect { user.add_role :some_new_role }.to change { user.current_role }.from(nil).to('some_new_role')
  end
end
