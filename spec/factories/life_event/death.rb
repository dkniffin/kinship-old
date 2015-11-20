FactoryGirl.define do
  factory :death, class: "LifeEvent::Death" do
    date { 1.week.ago }
  end
end
