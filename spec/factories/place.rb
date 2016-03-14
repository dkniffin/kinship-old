FactoryGirl.define do
  factory :place do
    street_address { '359 Blackwell Street' }
    city { 'Durham' }
    county { 'Durham' }
    state { 'NC' }
    postal_code { 27701 }
    country { 'USA' }
    lat { 35.992591 }
    lon { -78.903991 }

    # TODO: Associations
  end
end
