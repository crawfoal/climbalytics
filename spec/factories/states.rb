FactoryGirl.define do
  factory :state do
    postal_abbreviation { Faker::Address.state_abbr }
    full_name           { Faker::Address.state }
  end
end
