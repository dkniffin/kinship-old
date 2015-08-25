FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    role 'member'

    factory :unauthorized_user do
      role 'unauthorized'
    end
    factory :editor do
      role 'editor'
    end
    factory :admin do
      role 'admin'
    end
  end

  factory :person do
  end

  factory :birth do
  end
end
