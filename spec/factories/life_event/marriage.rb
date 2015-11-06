FactoryGirl.define do
  factory :marriage, class: "LifeEvent::Marriage" do
    date { 1.week.ago }

    trait :with_1_spouse do
      person_1 { build(:person) }
    end

    trait :with_2_spouses do
      person_1 { build(:person) }
      person_2 { build(:person) }
    end
  end
end
