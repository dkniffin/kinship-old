FactoryGirl.define do
  factory :death, class: "LifeEvent::Death" do
    date { Date.yesterday }
  end
end
