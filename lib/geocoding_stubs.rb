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

Geocoder::Lookup::Test.add_stub(
   "123 Main St., Somewhere, XX, 00000", [{
    'latitude'      => 0.0,
    'longitude'     => 0.0,
    'address'       => "123 Main St., Somewhere, XX, 00000",
    'state'         => 'Xoloraxo',
    'state_code'    => 'XX',
    'country'       => 'United States',
    'country_code'  => 'US'
  }]
)

# this is pretty bad coding style... find a better way
# > do we really need random latitude and longitude? maybe we could have an assortment of generic location factories, each with their own stub
module Geocoder
  module Lookup
    class Test < Base
      class << self
        alias orig_read_stub read_stub
        def read_stub(query_text)
          results = orig_read_stub(query_text)
          if query_text == "123 Main St., Somewhere, XX, 00000"
            results.first['latitude'] = Faker::Address.latitude
            results.first['longitude'] = Faker::Address.longitude
          end
          return results
        end
      end
    end
  end
end
