FactoryGirl.define do
  factory :location do

    # will get latitutde and longitude from default stub
    trait :with_address do
      address
    end

    factory :location_with_address do
      with_address
    end

    factory :location_without_address do
      address nil
    end

    factory :ww_location do
      association :address, factory: :ww_address

      trait :with_coords_only do
        latitude 47.654717
        longitude -117.415597
        address nil
      end
    end

    factory :bb_ny_location do
      association :address, factory: :bb_ny_address
    end

    factory :front_sc_location do
      association :address, factory: :front_sc_address
    end
  end
end
