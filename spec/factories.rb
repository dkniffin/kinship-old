FactoryGirl.define do
  factory :user do
    name     "Joe Schmoe"
    email    "jschmoe@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end