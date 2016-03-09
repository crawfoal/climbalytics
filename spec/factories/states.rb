FactoryGirl.define do
  factory :state do
    postal_abbreviation { Faker::Address.state_abbr }
    full_name           { Faker::Address.state }

    factory :wa do
      postal_abbreviation 'WA'
      full_name 'Washington'
    end
  end
end
