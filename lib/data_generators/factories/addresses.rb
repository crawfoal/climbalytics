FactoryGirl.define do
  factory :generic_address, class: Address do
    line1 '123 Main St.'
    city  'Somewhere'
    association :state, factory: :generic_state
    zip   '00000'
  end
end
