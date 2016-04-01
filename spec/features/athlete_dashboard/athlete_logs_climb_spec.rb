require 'feature_suite_helper'

feature 'Athlete Dashboard:' do
  scenario 'athlete starts logging a climb', js: true do
    setter = create :setter, setter_climb_logs_count: 1
    climb = setter.setter_story.setter_climb_logs.last.climb
    climb.update(grade: climb.type.constantize.grades.keys.sample)
    user = create :athlete
    create :athlete_climb_log, gym: climb.gym, athlete_story: user.athlete_story

    capybara_login(user)
    log_climb_panel = log_climb_panel_on_page

    log_climb_panel.click
    log_climb_panel.choose_most_recent_gym
    log_climb_panel.choose_first_climb

    expect(athlete_climb_log_form_on_page).to have_these_climb_field_presets climb.attributes
  end
end

def log_climb_panel_on_page
  AthleteDashboard::LogClimbPanel.new
end

def athlete_climb_log_form_on_page
  AthleteClimbLogForm.new
end
