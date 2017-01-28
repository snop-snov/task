FactoryGirl.define do
  factory :user do
    name { generate :name }
    email { generate :email }
    password { generate :string }
    password_confirmation { password }

    trait :dispatcher do
      role :dispatcher
    end

    trait :driver do
      role :driver
    end
  end
end
