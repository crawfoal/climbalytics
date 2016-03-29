require 'rails_helper'

def expect_role_section_to_be_hidden
  expect(find('section.roles')).to_not have_selector 'input[type="checkbox"]'
end
def expect_role_section_to_be_visible
  expect(find('section.roles')).to have_selector 'input[type="checkbox"]'
end

def expect_name_section_to_be_hidden
  expect(find('section.name')).to_not have_selector 'input[id*="user_name_attributes"]'
end
def expect_name_section_to_be_visible
  expect(find('section.name')).to have_selector 'input[id*="user_name_attributes"]'
end

feature 'User edits profile:' do
  let(:user) { create :user }
  before :each do
    visit new_user_account_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.account.password
    click_on 'Log in'
    click_on 'Edit Profile'
  end
  scenario 'name can be changed' do
    fill_in 'First', with: 'first'
    fill_in 'Last', with: 'last'
    click_on 'Update'
    expect(page).to have_content('Profile was successfully updated.')
    user.reload
    expect(user.name.first).to eq 'first'
    expect(user.name.last).to eq 'last'
  end
  scenario 'user can select roles' do
    expect(Role.defined_roles.size).to be >= 1
    Role.defined_roles.each do |role|
      check role
    end
    click_on 'Update'
    expect(page).to have_content('Profile was successfully updated.')
    Role.defined_roles.each do |role|
      expect(user).to have_role role
    end
  end
  scenario 'the role section is not collapsed', js: true do
    expect_role_section_to_be_visible
  end
  scenario 'the name section is not collapsed', js: true do
    expect_name_section_to_be_visible
  end

  context 'user has at least one role', js: true do
    let(:user) { create :athlete }
    scenario 'the role section is collapsed' do
      expect_role_section_to_be_hidden
    end
    scenario 'the role section can be opened and closed', js: true do
      find('section.roles i.fa-toggle-down').click
      expect_role_section_to_be_visible
      expect(find('section.roles')).to_not have_selector 'i.fa-toggle-down'
      find('section.roles i.fa-toggle-up').click
      expect_role_section_to_be_hidden
      expect(find('section.roles')).to have_selector 'i.fa-toggle-down'
    end
  end

  context 'the user has saved their first name' do
    let(:user) { create(:user, name: create(:name, first: 'Amanda')) }

    scenario 'the name section is collapsed', js: true do
      expect_name_section_to_be_hidden
    end
    scenario 'the name section can be opened and closed', js: true do
      find('section.name i.fa-toggle-down').click
      expect_name_section_to_be_visible
      expect(find('section.name')).to_not have_selector 'i.fa-toggle-down'
      find('section.name i.fa-toggle-up').click
      expect_name_section_to_be_hidden
      expect(find('section.name')).to have_selector 'i.fa-toggle-down'
    end
  end
end
