FactoryGirl.define do
  factory :person do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    gender { Person.all_genders.sample }
    birth
  end
end
