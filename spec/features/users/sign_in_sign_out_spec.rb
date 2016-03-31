require 'rails_helper'

feature 'Authentication:' do
  scenario '(new) user signs in and out' do
    capybara_login create(:user)

    expect(current_url).to include edit_user_path

    click_on 'Logout'
    expect(page).to have_content 'Signed out successfully.'
  end
end
