FactoryGirl.define do
  factory :birth, class: "LifeEvent::Birth" do
    date { Date.yesterday }
  end
end
