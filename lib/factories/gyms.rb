FactoryGirl.define do
  factory :_gym_, parent: :gym do
    transient do
      location_factory :_location_
      num_sections { Faker::Number.between(1,5) }
    end
  end
end
