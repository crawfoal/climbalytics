require 'rails_helper'

feature 'When user views the setter_climb_log index' do
  let(:setter_climb_logs) { create_list(:setter_climb_log, 3) }

  context 'and does not have a role of setter' do
    let(:user) { create(:user) }

    before :each do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'
      setter_climb_logs
      visit setter_climb_logs_path
    end

    scenario 'every setter_climb_log defined is listed'
    scenario 'they can view each setter_climb_log' do
      setter_climb_logs.each do |setter_climb_log|
        expect(page).to have_link('Show', href: setter_climb_log_path(setter_climb_log))
      end
    end
    scenario 'they cannot edit any setter_climb_logs' do
      setter_climb_logs.each do |setter_climb_log|
        expect(page).to_not have_link('Edit', href: edit_setter_climb_log_path(setter_climb_log))
      end
    end
    scenario 'they cannot delete any setter_climb_logs' do
      setter_climb_logs.each do |setter_climb_log|
        expect(page).to_not have_link('Destroy', href: setter_climb_log_path(setter_climb_log))
      end
    end
    scenario 'they cannot create a new setter_climb_log' do
      expect(page).to_not have_link('New SetterClimbLog', new_setter_climb_log_path)
    end
  end

  context 'and has a role of setter' do
    let(:setter_user) { create(:user, roles: [:setter]) }
    let(:setter_climb_log) { setter_user.setter_story.setter_climb_logs.create }

    before :each do
      visit new_user_session_path
      fill_in 'Email', with: setter_user.email
      fill_in 'Password', with: setter_user.password
      click_on 'Log in'
      setter_climb_logs
      setter_climb_log
      visit setter_climb_logs_path
    end

    scenario 'every setter_climb_log defined is listed'
    scenario 'they can view each setter_climb_log' do
      setter_climb_logs.each do |setter_climb_log|
        expect(page).to have_link('Show', href: setter_climb_log_path(setter_climb_log))
      end
    end
    scenario 'they cannot edit setter_climb_logs they do not own' do
      setter_climb_logs.each do |setter_climb_log|
        expect(page).to_not have_link('Edit', href: edit_setter_climb_log_path(setter_climb_log))
      end
    end
    scenario 'they cannot delete setter_climb_logs they do not own' do
      setter_climb_logs.each do |setter_climb_log|
        expect(page).to_not have_link('Destroy', href: setter_climb_log_path(setter_climb_log))
      end
    end
    scenario 'they can edit setter_climb_logs they own' do
      expect(page).to have_link('Edit', href: edit_setter_climb_log_path(setter_climb_log))
    end
    scenario 'they can delete setter_climb_logs they own' do
      expect(page).to have_link('Destroy', href: setter_climb_log_path(setter_climb_log))
    end
  end
end
