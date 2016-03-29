require 'rails_helper'

feature 'User Roles:' do
  scenario 'user switches current role', js: true do
    @user = create(:user, roles: [:athlete])
    @user.add_role :setter
    visit new_user_account_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.user_account.password
    click_on 'Log in'
    expect(@user.current_role).to eq 'athlete'
    click_on 'Change Roles'
    click_on 'setter'
    expect(current_path).to include setter_dashboard_path
    expect(@user.reload.current_role).to eq 'setter'
  end
end
