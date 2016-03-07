require 'rails_helper'

feature 'Athlete logs a climb from their dashboard', js: true do
  context "We don't know the user's current location" do
    before :each do
      user = create(:athlete)
      visit root_path
      within '.signin-fields' do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.account.password
        click_on 'Log in'
      end
      within('.log-a-climb') { click_on 'Log' }
    end

    context 'The browser allows/supports geolocation' do
      before :each do
        page.execute_script "navigator.geolocation.getCurrentPosition = function(success) { success({coords: {latitude: 47.654717, longitude: -117.415597}}); }"
      end

      scenario 'The user triggers geolocation' do
        click_on 'find-me'
        expect(page).to have_link 'refresh-my-location'
      end
    end

    context 'The browser does not support geolocation' do
      before :each do
        page.execute_script "navigator.geolocation.getCurrentPosition = function(success, error) { error(); }"
      end

      scenario 'The user triggers geolocation' do
        click_on 'find-me'
        expect(page).to have_content "We were not able to find your location."
      end
    end
  end

  scenario "The user wants to select a gym they've recently used"
end
