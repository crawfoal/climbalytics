require 'rails_helper'

def setup_gym_and_climb_data
  wild_walls # create the gym before the setter & his log, so that the climb gets created at Wild Walls
  # In the line below, the climb that is associated with the setter_climb_log will be associated with the section created for Wild Walls (created via `let`). This is because of the way the setter_climb_log factory works... it is a little weird, and it would be nice if we could have this behavior be more explicit and obvious.
  create :setter, setter_climb_logs_count: 1
  climb = Climb.last
  climb.update(grade: climb.type.constantize.grades.keys.sample)
end

def select_climb_and_expect_form_to_appear
  expect(page).to have_css '.climb-links', wait: 3

  within '.climb-links' do
    first('.loggable-link').click
  end
  expect(page).to have_css '.new_athlete_climb_log'
end

def check_field_presets_for_climb
  expect(page).to have_select "athlete_climb_log[climb_attributes][gym_section_id]", selected: gym_section.name
  expect(page).to have_checked_field climb.type
  expect(page).to have_select "athlete_climb_log[climb_attributes][grade]", selected: climb.grade
end

def save_and_expect_success
  click_on 'Save'
  expect(page).to have_content 'success'
end

feature 'Athlete logs a climb' do
  let(:wild_walls) { create :gym, name: 'Wild Walls', location_factory: :ww_location, num_sections: 1 }
  let(:gym_section) { wild_walls.sections.first }
  let(:climb) { gym_section.climbs.first }
  let(:user) { create :athlete }

  context 'from the dashboard', js: true do

    scenario 'for a nearby gym' do
      skip 'need to work out geolocation stubbing...' # it works sometimes... especially when this spec is simpler

      setup_gym_and_climb_data
      capybara_login(user)
      simulate_location 47.627867, -117.662724 # pretend we're close to Wild Walls
      within('.log-a-climb') { click_on 'Log' }

      click_on 'find-me'
      expect(page).to have_link 'refresh-my-location', wait: 3

      within '.nearby-gyms' do
        click_on 'Wild Walls'
      end

      select_climb_and_expect_form_to_appear

      check_field_presets_for_climb
    end

    scenario 'for a recent gym' do
      setup_gym_and_climb_data
      create(:athlete_climb_log, athlete_story: user.athlete_story, gym: wild_walls)
      capybara_login(user)
      within('.log-a-climb') { click_on 'Log' }

      within '.recent-gyms' do
        first('.gym-link').click
      end

      select_climb_and_expect_form_to_appear

      check_field_presets_for_climb

      save_and_expect_success
    end
  end
end
