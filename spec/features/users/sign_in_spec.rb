require 'rails_helper'

feature 'User signs in' do
  scenario 'with valid credentials' do
    user = create(:user, roles: [:athlete])
    visit new_user_account_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.user_account.password
    click_on 'Log in'
    expect(page).to have_content('Log a climb')
  end
  scenario 'without valid credentials (i.e. not signed up yet)' do
    user = build(:user, user_account: build(:user_account))
    visit new_user_account_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.user_account.password
    click_on 'Log in'
    expect(page).to have_content('Invalid email or password.')
  end
  scenario 'with incorrect password' do
    user = create(:user)
    visit new_user_account_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: "#{user.user_account.password}_modified"
    click_on 'Log in'
    expect(page).to have_content('Invalid email or password.')
  end
end
