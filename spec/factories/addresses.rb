FactoryGirl.define do
  factory :address do
    line1         { Faker::Address.street_address }
    city          { Faker::Address.city }
    state
    zip           { Faker::Address.zip.to_i }
  end
end
