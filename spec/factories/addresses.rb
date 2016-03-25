FactoryGirl.define do
  factory :address do
    line1         { Faker::Address.street_address }
    city          { Faker::Address.city }
    state
    zip           { Faker::Address.zip.to_i }

    factory :ww_address do
      line1 '202 West Second Avenue'
      city 'Spokane'
      zip '99201'
      association :state, factory: :wa
    end

    factory :bb_ny_address do
      line1 '575 Degraw St'
      city 'Brooklyn'
      zip '11217'
      association :state, factory: :ny
    end

    factory :front_sc_address do
      line1 '1470 400 W'
      city 'Salt Lake City'
      zip '84115'
      association :state, factory: :ut
    end
  end
end
