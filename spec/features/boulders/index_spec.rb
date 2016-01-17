require 'rails_helper'

feature 'When user views the boulder problem index' do
  let(:boulders) { create_list(:boulder, 3) }

  context 'and does not have a role of setter' do
    let(:user) { create(:user) }

    before :each do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'
      boulders
      visit boulders_path
    end

    scenario 'every boulder problem defined is listed' do
      expect(page.text).to include( *(boulders.map { |boulder| [boulder.name, boulder.grade] }).flatten )
    end
    scenario 'they can view each boulder problem' do
      boulders.each do |boulder|
        expect(page).to have_link('Show', href: boulder_path(boulder))
      end
    end
    scenario 'they cannot edit any boulder problems' do
      boulders.each do |boulder|
        expect(page).to_not have_link('Edit', href: edit_boulder_path(boulder))
      end
    end
    scenario 'they cannot delete any boulder problems' do
      boulders.each do |boulder|
        expect(page).to_not have_link('Destroy', href: boulder_path(boulder))
      end
    end
    scenario 'they cannot create a new boulder problem' do
      expect(page).to_not have_link('New Boulder', new_boulder_path)
    end
  end

  context 'and has a role of setter' do
    let(:setter_user) { create(:setter_user) }
    let(:boulder) { setter_user.setter_story.boulders.create(name: "Sam's Boulder Problem", grade: 'V5') }

    before :each do
      visit new_user_session_path
      fill_in 'Email', with: setter_user.email
      fill_in 'Password', with: setter_user.password
      click_on 'Log in'
      boulders
      boulder
      visit boulders_path
    end

    scenario 'every boulder problem defined is listed' do
      expect(page.text).to include( *(boulders.map { |boulder| [boulder.name, boulder.grade] }).flatten )
    end
    scenario 'they can view each boulder problem' do
      boulders.each do |boulder|
        expect(page).to have_link('Show', href: boulder_path(boulder))
      end
    end
    scenario 'they cannot edit boulder problems they do not own' do
      boulders.each do |boulder|
        expect(page).to_not have_link('Edit', href: edit_boulder_path(boulder))
      end
    end
    scenario 'they cannot delete boulder problems they do not own' do
      boulders.each do |boulder|
        expect(page).to_not have_link('Destroy', href: boulder_path(boulder))
      end
    end
    scenario 'they can edit boulder problems they own' do
      expect(page).to have_link('Edit', href: edit_boulder_path(boulder))
    end
    scenario 'they can delete boulder problems they own' do
      expect(page).to have_link('Destroy', href: boulder_path(boulder))
    end
  end
end
