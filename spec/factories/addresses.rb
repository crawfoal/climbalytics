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
  end
end
