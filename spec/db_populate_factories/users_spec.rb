require 'main_suite_helper'

describe 'db:populate' do
  describe 'generated users' do
    it 'gives the user a name (half of the time)' do
      user = create(:_user_)
      expect(user.name).to_not be_nil
    end
  end
end
