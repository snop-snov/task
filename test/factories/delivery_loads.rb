FactoryGirl.define do
  factory :delivery_load do
    date

    trait :with_driver do
      driver { create :user, :driver }
    end

    trait :morning do
      delivery_shift 'M'
    end

    trait :afternoon do
      delivery_shift 'A'
    end

    trait :evening do
      delivery_shift 'E'
    end
  end
end
