require 'rails_helper'

feature 'User signs up for an account' do
  subject { page }

  context 'with valid credentials' do
    before :each do
      visit root_path
      within '.signup' do
        fill_in 'Email', with: 'new_user@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_on 'Sign up'
      end
    end

    it { should have_content 'Welcome! You have signed up successfully.' }
    it { should have_css '.roles .collapse.in' }
    it { should have_css '.name .collapse.in' }

    context 'and the user selects and submits a role' do
      before :each do
        check 'athlete'
        click_on 'Update'
      end
      it { should have_content 'Log a climb' }
    end
  end
end
