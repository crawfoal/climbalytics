require 'rails_helper'

feature "User destroys profile" do
  # scenario 'valid user logs in and destroys profile' do
  #   user = create(:user)
  #   visit new_user_account_session_path
  #   fill_in 'Email', with: user.email
  #   fill_in 'Password', with: user.user_account.password
  #   click_on 'Log in'
  #   click_on 'Edit profile'
  #   click_on 'Cancel my account'
  #   expect(page).to have_content('Log in')
  # end
  # scenario 'profile can not be destroyed with out password' do
  #   user = create(:user)
  #   visit new_user_account_session_path
  #   fill_in 'Email', with: user.email
  #   click_on 'Log in'
  #   click_on 'Edit profile'
  #   click_on 'Cancel my account'
  #   expect(page).to have_content("Current password can't be blank")
  # end
end
