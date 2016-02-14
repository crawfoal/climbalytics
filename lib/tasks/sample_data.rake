require_relative "../helpers/db_populate/make_users.rb"

namespace :db do
  desc "Fill database with sample data"
  task :populate => :only_dev do
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

    # make users, as well as climb logs, seshes and related
    MakeUsers.make_users
  end
end
