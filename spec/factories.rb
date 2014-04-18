FactoryGirl.define do
  factory :user do
    username "jschmoe"
    email    "jschmoe@example.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :admin, :parent => :user do
   	role User::ROLE_ADMIN
  end

  factory :person do
  end
end