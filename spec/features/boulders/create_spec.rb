require 'rails_helper'

feature 'User creates a setter_climb_log' do
  let(:user) { create(:user, roles: [:setter]) }

  context 'when user has role of setter' do
    before :each do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'
    end

    scenario 'from setter dashboard' do
      within(".panel.create") do
        click_on 'setter climb log'
      end
      expect(page).to have_content 'New SetterClimbLog'
      expect(page).to have_button 'Create Setter climb log'
    end

  end

end
