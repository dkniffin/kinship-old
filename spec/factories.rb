FactoryGirl.define do
  factory :user do
    username "jschmoe"
    email    "jschmoe@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end