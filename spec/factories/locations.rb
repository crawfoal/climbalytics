FactoryGirl.define do
  factory :location do

    # will get latitutde and longitude from default stub
    trait :with_address do
      address
    end

    factory :ww_location do
      association :address, factory: :ww_address
    end

    factory :bb_ny_location do
      association :address, factory: :bb_ny_address
    end

    factory :front_sc_location do
      association :address, factory: :front_sc_address
    end
  end
end
