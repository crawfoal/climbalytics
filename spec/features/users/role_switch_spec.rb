require 'rails_helper'

feature 'User Roles:' do
  scenario 'user switches current role', js: true do
    user = create(:user, roles: [:athlete])
    user.add_role :setter
    capybara_login(user)
    expect(user.current_role).to eq 'athlete'

    click_on 'Change Roles'
    click_on 'setter'
    
    expect(current_path).to include setter_dashboard_path
    expect(user.reload.current_role).to eq 'setter'
  end
end
