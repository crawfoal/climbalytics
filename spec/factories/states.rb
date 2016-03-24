FactoryGirl.define do
  factory :state do
    postal_abbreviation { Faker::Address.state_abbr }
    full_name           { Faker::Address.state }

    factory :wa do
      postal_abbreviation 'WA'
      full_name 'Washington'
    end

    factory :ny do
      postal_abbreviation 'NY'
      full_name 'New York'
    end

    factory :ut do
      postal_abbreviation 'UT'
      full_name 'Utah'
    end
  end
end
