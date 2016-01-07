require 'rails_helper'

feature 'User Roles:' do
  before :each do
    @user = create(:user)
    @user.add_role :role1
    @user.add_role :role2
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on 'Log in'
  end
  scenario 'user switches current role' do
    select 'role1', from: 'user_current_role'
    expect(page).to have_content 'role1'
  end
end
