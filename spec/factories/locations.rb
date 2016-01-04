FactoryGirl.define do
  factory :location do
    name 'Location Name'
    factory :location_without_address do
      name 'I do not have an address yet!'
    end
  end
end
