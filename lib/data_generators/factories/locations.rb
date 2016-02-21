FactoryGirl.define do
  factory :generic_location, class: Location do
    association :address, factory: :generic_address
  end
end
