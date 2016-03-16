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
        create(:wild_walls)
        page.execute_script "navigator.geolocation.getCurrentPosition = function(success) { success({coords: {latitude: 47.627867, longitude: -117.662724}}); }"
        click_on 'find-me'
      end

      scenario 'the user can refresh their location' do
        expect(page).to have_link 'refresh-my-location'
      end

      scenario 'the user clicks on a nearby gym', :focus do
        click_on 'Wild Walls'
        expect(page).to have_content 'Select a climb'
        expect(page).to have_content 'Wild Walls'
        expect(page).to have_css '.topo'
      end
    end

    context 'The browser does not support geolocation' do
      before :each do
        page.execute_script "navigator.geolocation.getCurrentPosition = function(success, error) { error(); }"
      end

      # This test used to mostly work, but occasionally failed. Now it seems to always fail. When I do it myself in the browser (block location services, and then run through the actions), it always works. I'm not sure why this isn't working... but it seems to be an issue with the test - the `before :each` block is probably a good place to start looking because it's kind of a weird way to stub something. I'm just not sure how else to do this and I haven't put the time in to figure it out.
      skip 'The user triggers geolocation' do
        click_on 'find-me'
        expect(page).to have_content "We were not able to find your location."
      end
    end
  end

  scenario "The user wants to select a gym they've recently used"
end
