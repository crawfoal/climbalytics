require 'rails_helper'

feature 'User signs out' do
  scenario 'with valid session' do
    user = create(:user)
    visit new_user_account_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.user_account.password
    click_on 'Log in'
    click_on 'Logout'
    expect(page).to have_content('Signed out successfully.')
  end
end
