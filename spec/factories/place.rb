FactoryGirl.define do
  factory :place do
    street_address { Faker::Address.street_address }
    city { Faker::Address.city }
    county { 'Some county' }
    state { Faker::Address.state }
    postal_code { Faker::Address.postcode }
    country { Faker::Address.country }
    lat { Faker::Address.latitude }
    lon { Faker::Address.longitude }

    # TODO: Associations
  end
end
