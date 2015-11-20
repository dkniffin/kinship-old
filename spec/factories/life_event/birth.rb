FactoryGirl.define do
  factory :birth, class: "LifeEvent::Birth" do
    date { 1.week.ago }
  end
end
