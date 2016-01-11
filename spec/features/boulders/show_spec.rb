require 'rails_helper'

feature 'User views a boulder problem' do
  let(:boulder) { create(:boulder) }

  context 'when user does not have a role of setter' do
    let(:user) { create(:user) }

    before :each do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'
      visit boulder_path(boulder)
    end

    scenario 'they can view the boulder problem' do
      expect(page.text).to include(boulder.name, boulder.grade)
    end

    scenario 'they cannot edit the boulder problem' do
      within('.container.page-content') do
        expect(page).to_not have_link('Edit', href: edit_boulder_path(boulder))
      end
    end

    scenario 'they cannot delete the boulder problem' do
      expect(page).to_not have_link('Delete', href: boulder_path(boulder))
    end
  end

  context 'when user has a role of setter' do
    before :all do
      define_roles(:setter)
    end

    let(:setter_user) { create(:setter_user) }

    before :each do
      visit new_user_session_path
      fill_in 'Email', with: setter_user.email
      fill_in 'Password', with: setter_user.password
      click_on 'Log in'
    end

    context 'and they own the boulder problem' do
      let(:boulder) { setter_user.setter_story.boulders.create(name: "Sam's Boulder Problem", grade: 'V5') }

      before :each do
        visit boulder_path(boulder)
      end

      scenario 'they can view the boulder problem' do
        expect(page.text).to include(boulder.name, boulder.grade)
      end

      scenario 'they can edit the boulder problem' do
        within('.container.page-content') do
          expect(page).to have_link('Edit', href: edit_boulder_path(boulder))
        end
      end

      scenario 'they can delete the boulder problem' do
        expect(page).to have_link('Delete', href: boulder_path(boulder))
      end
    end

    context 'but they do not own the boulder problem' do
      before :each do
        visit boulder_path(boulder)
      end

      scenario 'they can view the boulder problem' do
        expect(page.text).to include(boulder.name, boulder.grade)
      end

      scenario 'they cannot edit the boulder problem' do
        within('.container.page-content') do
          expect(page).to_not have_link('Edit', href: edit_boulder_path(boulder))
        end
      end

      scenario 'they cannot delete the boulder problem' do
        expect(page).to_not have_link('Delete', href: boulder_path(boulder))
      end
    end

  end

end
