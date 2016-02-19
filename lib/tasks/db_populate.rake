require "#{Rails.root}/lib/data_generators"

namespace :db do
  desc "Fill database with sample data"
  task :populate => :non_prod do
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

    Rake::Task['db:reset'].invoke

    # Create some "new" users (users that don't have a role yet).
    UserGenerator.new.generate_set

    AthleteGenerator.new.generate_set
  end
end
