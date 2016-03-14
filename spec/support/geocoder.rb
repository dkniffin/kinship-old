Geocoder.configure(:lookup => :test)

Geocoder::Lookup::Test.add_stub(
  'Durham, NC', [
    {
      'address'      => 'Durham, NC, USA',
      'state'        => 'North Carolina',
      'state_code'   => 'NC',
      'country'      => 'United States',
      'country_code' => 'US',
      'lat'          => 35.992591,
      'lon'          => -78.903991
    }
  ]
)

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
