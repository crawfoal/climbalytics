FactoryGirl.define do
  factory :address do
    line1         '123 Main Street'
    city          'Boulder'
    state
    zip           '80302'
    factory :user_address do
      association :addressable, factory: :user
    end
  end
end
