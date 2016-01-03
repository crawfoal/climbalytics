require 'rails_helper'

feature 'User signs out' do
  scenario 'with valid session' do
    user = create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    click_on 'Logout'
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
