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
  "123 Main St., Somewhere, XX, 00000", [
    'latitude'      => Faker::Address.latitude,
    'longitude'     => Faker::Address.longitude,
    'address'       => "123 Main St., Somewhere, XX, 00000",
    'state'         => 'Xoloraxo',
    'state_code'    => 'XX',
    'country'       => 'United States',
    'country_code'  => 'US'
  ]
)
