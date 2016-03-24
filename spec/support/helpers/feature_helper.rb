module FeatureHelper
  # http://grosser.it/2012/04/19/testing-geolocation-with-capybara-selenium-firefox/
  def simulate_location(lat, lng)
    page.driver.browser.execute_script <<-JS
      window.navigator.geolocation.getCurrentPosition = function(success){
        var position = {"coords" : {"latitude": "#{lat}", "longitude": "#{lng}"}};
        success(position);
      }
    JS
    sleep 0.3 # make sure that the above script finishes executing before the caller of this function tries to do something on the page
  end

  def capybara_login(user)
    visit root_path
    within '.signin-fields' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.account.password
      click_on 'Log in'
    end
  end
end

RSpec.configure do |config|
  config.include FeatureHelper, type: :feature
end
