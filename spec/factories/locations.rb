FactoryGirl.define do
  factory :location do

    # will get latitutde and longitude from default stub
    trait :with_address do
      address
    end

    factory :ww_location do
      association :address, factory: :ww_address
    end
  end
end
