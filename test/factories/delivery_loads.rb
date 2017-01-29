FactoryGirl.define do
  factory :delivery_load do
    date

    after :build do |l|
      l.driver = create(:user, :driver)
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
