require "#{Rails.root}/lib/data_generators/base.rb"
require "#{Rails.root}/lib/factory_manager.rb"
require "#{Rails.root}/lib/sometimes.rb"
Dir[Rails.root.join('lib/data_generators/**/*.rb')].each { |f| require f }

include Sometimes

# Don't actually call out to Google API when creating sample data. We can configure Geocoder to have different stubs, e.g. we can say "when there is a query for foo, return bar". See the documentation.
Geocoder.configure(:lookup => :test)

Geocoder::Lookup::Test.set_default_stub(
  [
    {
      'latitude'     => 40.7143528,
      'longitude'    => -74.0059731,
      'address'      => 'New York, NY, USA',
      'state'        => 'New York',
      'state_code'   => 'NY',
      'country'      => 'United States',
      'country_code' => 'US'
    }
  ]
)
