require 'feature_suite_helper'

feature 'Athlete Dashboard:' do
  scenario 'new athelete triggers geolocation', js: true do
    capybara_login(create :athlete)
    simulate_location 47.627867, -117.662724 # location near Wild Walls
    log_climb_panel = AthleteDashboard::LogClimbPanel.new

    log_climb_panel.trigger_geolocation

    expect(log_climb_panel).to have_current_location_of_user
  end
end
