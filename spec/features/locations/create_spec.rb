require 'rails_helper'

feature 'user creates a location' do

  scenario 'any valid user can create a new location' do

    user = create(:user)
    address = create(:location_address)
    location = address.addressable

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    visit new_location_path
    fill_in 'Name', with: location.name
    fill_in 'Line 1', with: address.line1
    fill_in 'Line 2', with: address.line2
    fill_in 'City', with: address.city
    select address.state.full_name, from: 'State'
    fill_in 'Zip', with: address.zip
    click_on 'Create Location'

    expect(page).to have_content 'Location was successfully created.'
    expect(page).to have_content location.name
    expect(page).to have_content address.line1
    expect(page).to have_content address.line2
    expect(page).to have_content address.city
    expect(page).to have_content address.state.postal_abbreviation
    expect(page).to have_content address.zip

  end

end
