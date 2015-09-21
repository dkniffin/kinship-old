FactoryGirl.define do
  factory :marriage do
    person_1 { build(:person) }
    person_2 { build(:person) }
  end
end
