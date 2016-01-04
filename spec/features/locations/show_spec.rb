require 'rails_helper'

feature 'user views a location:' do

  before :each do
    user = create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  scenario 'valid user, full location details' do

    address = create(:location_address)
    location = address.addressable

    visit location_path(location.id)
    expect(page).to have_content location.name
    expect(page).to have_content address.line1
    expect(page).to have_content address.line2
    expect(page).to have_content address.city
    expect(page).to have_content address.state.postal_abbreviation
    expect(page).to have_content address.zip

  end

  scenario 'valid user, location does not have an address' do
    location = create(:location_without_address)
    location.create_address
    visit location_path(location.id)
    expect(page).to_not have_content 'Address:'
  end

end
