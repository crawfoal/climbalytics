require 'rails_helper'

feature 'user edits a location' do

  scenario 'any valid user can create a new location' do

    user = create(:user)
    address = create(:location_address)
    location = address.addressable

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    visit edit_location_path(location.id)
    fill_in 'Name', with: location.name.upcase
    fill_in 'Line 1', with: address.line1.upcase
    fill_in 'City', with: address.city.upcase
    select address.state.full_name, from: 'State'
    fill_in 'Zip', with: address.zip
    click_on 'Update Location'

    expect(page).to have_content('Location was successfully updated.')

  end

end
