require 'rails_helper'

feature 'User signs in' do
  scenario 'with valid credentials' do
    user = create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    expect(page).to have_content('Signed in successfully.')
  end
  scenario 'without valid credentials' do
    user = build(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    expect(page).to have_content('Invalid email or password.')
  end
  scenario 'with incorrect password' do
    user = build(:user, password: 'passwor')
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    expect(page).to have_content('Invalid email or password.')
  end
end
