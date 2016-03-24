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
   "202 West Second Avenue, Spokane, WA, 99201", [{
    'latitude'      => 47.654717,
    'longitude'     => -117.415597,
    'address'       => "202 West Second Avenue, Spokane, WA, 99201",
    'state'         => 'Washington',
    'state_code'    => 'WA',
    'country'       => 'United States',
    'country_code'  => 'US'
  }]
)

Geocoder::Lookup::Test.add_stub(
  "575 Degraw St, Brooklyn, NY 11217", [{
    'latitude'      => 40.679627,
    'longitude'     => -73.984177,
    'address'       => '575 Degraw St, Brooklyn, NY 11217',
    'state'         => 'New York',
    'state_code'    => 'NY',
    'country'       => 'United States',
    'country_code'  => 'US'
  }]
)

Geocoder::Lookup::Test.add_stub(
  "1470 400 W, Salt Lake City, UT 84115", [{
    'latitude'      => 40.738232,
    'longitude'     => -111.903157,
    'address'       => '1470 400 W, Salt Lake City, UT 84115',
    'state'         => 'Utah',
    'state_code'    => 'UT',
    'country'       => 'United States',
    'country_code'  => 'US'
  }]
)
