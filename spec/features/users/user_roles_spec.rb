require 'rails_helper'

feature 'User Roles:' do
  scenario 'user switches current role', js: true do
    @user = create(:athlete_user)
    @user.add_role :setter
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on 'Log in'
    expect(@user.current_role).to eq 'athlete'
    click_on "Logged in as #{@user.address_me_as}"
    select 'setter', from: 'user_current_role'
    expect(@user.reload.current_role).to eq 'setter'
    click_on "Logged in as #{@user.address_me_as}"
    expect(page).to have_select('user_current_role', selected: 'setter')
    expect(page).to have_content 'Create a...'
  end
end
