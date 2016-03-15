FactoryGirl.define do
  factory :_location_, parent: :location do
    with_address
  end
end
