require 'rails_helper'

feature 'User creates a boulder problem' do
  let(:user) { create(:setter_user) }

  context 'when user has role of setter' do
    before :each do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'
    end

    scenario 'from setter dashboard' do
      within(".panel.create") do
        click_on 'boulder problem'
      end
      expect(page).to have_content 'New Boulder'
      expect(page).to have_button 'Create Boulder'
    end

  end

end
