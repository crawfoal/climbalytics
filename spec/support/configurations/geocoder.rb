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
