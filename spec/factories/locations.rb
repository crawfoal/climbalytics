FactoryGirl.define do
  factory :location do

    trait :with_address do
      address
    end
  end
end
