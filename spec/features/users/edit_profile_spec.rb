require 'rails_helper'

feature 'User edits profile' do
  before :each do
    @user = create(:user)
    @state = create(:state)
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on 'Log in'
    click_on 'Edit profile'
  end
  scenario 'password can be changed' do
    new_password = @user.password.upcase
    fill_in 'New password', with: new_password
    fill_in 'New password confirmation', with: new_password
    fill_in 'Current password', with: @user.password
    click_on 'Update'
    expect(page).to have_content('Your account has been updated successfully.')
  end
  scenario 'name can be changed' do
    fill_in 'First', with: 'first'
    fill_in 'Last', with: 'last'
    fill_in 'Current password', with: @user.password
    click_on 'Update'
    expect(page).to have_content('Your account has been updated successfully.')
  end
  scenario 'address can be changed' do
    fill_in 'Line 1', with: 'line 1'
    fill_in 'Line 2', with: 'line 2'
    fill_in 'City', with: 'City'
    select @state.full_name, from: 'State'
    fill_in 'Zip', with: '80302'
    fill_in 'Current password', with: @user.password
    click_on 'Update'
    expect(page).to have_content('Your account has been updated successfully.')
  end
  scenario 'changes can not be made without entering a password' do
    fill_in 'First', with: 'first'
    fill_in 'Last', with: 'last'
    click_on 'Update'
    expect(page).to have_content("Current password can't be blank")
  end
end
