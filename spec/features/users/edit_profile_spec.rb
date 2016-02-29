require 'rails_helper'

feature 'User edits profile:' do
  before :each do
    @user = create(:user)
    @state = create(:state)
    visit new_user_account_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.user_account.password
    click_on 'Log in'
    click_on 'Edit profile'
  end
  scenario 'name can be changed' do
    fill_in 'First', with: 'first'
    fill_in 'Last', with: 'last'
    click_on 'Update'
    expect(page).to have_content('Profile was successfully updated.')
    @user.reload
    expect(@user.name.first).to eq 'first'
    expect(@user.name.last).to eq 'last'
  end
  scenario 'user can select roles' do
    expect(Role.defined_roles.size).to be >= 1
    Role.defined_roles.each do |role|
      check role
    end
    click_on 'Update'
    expect(page).to have_content('Profile was successfully updated.')
    Role.defined_roles.each do |role|
      expect(@user).to have_role role
    end
  end
end
