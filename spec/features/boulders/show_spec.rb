require 'rails_helper'

feature 'User views a setter_climb_log' do
  let(:setter_climb_log) { create(:setter_climb_log) }

  context 'when user does not have a role of setter' do
    let(:user) { create(:user) }

    before :each do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'
      visit setter_climb_log_path(setter_climb_log)
    end

    scenario 'they can view the setter_climb_log'

    scenario 'they cannot edit the setter_climb_log' do
      within('.container.page-content') do
        expect(page).to_not have_link('Edit', href: edit_setter_climb_log_path(setter_climb_log))
      end
    end

    scenario 'they cannot delete the setter_climb_log' do
      expect(page).to_not have_link('Delete', href: setter_climb_log_path(setter_climb_log))
    end
  end

  context 'when user has a role of setter' do

    let(:setter_user) { create(:user, roles: [:setter]) }

    before :each do
      visit new_user_session_path
      fill_in 'Email', with: setter_user.email
      fill_in 'Password', with: setter_user.password
      click_on 'Log in'
    end

    context 'and they own the setter_climb_log' do
      let(:setter_climb_log) { setter_user.setter_story.setter_climb_logs.create }

      before :each do
        visit setter_climb_log_path(setter_climb_log)
      end

      scenario 'they can view the setter_climb_log'

      scenario 'they can edit the setter_climb_log' do
        within('.container.page-content') do
          expect(page).to have_link('Edit', href: edit_setter_climb_log_path(setter_climb_log))
        end
      end

      scenario 'they can delete the setter_climb_log' do
        expect(page).to have_link('Delete', href: setter_climb_log_path(setter_climb_log))
      end
    end

    context 'but they do not own the setter_climb_log' do
      before :each do
        visit setter_climb_log_path(setter_climb_log)
      end

      scenario 'they can view the setter_climb_log'

      scenario 'they cannot edit the setter_climb_log' do
        within('.container.page-content') do
          expect(page).to_not have_link('Edit', href: edit_setter_climb_log_path(setter_climb_log))
        end
      end

      scenario 'they cannot delete the setter_climb_log' do
        expect(page).to_not have_link('Delete', href: setter_climb_log_path(setter_climb_log))
      end
    end

  end

end
