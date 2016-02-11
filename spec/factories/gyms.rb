FactoryGirl.define do
  factory :gym do
    name "MyString"
    topo "MyString"

    trait :no_name do
      name nil
    end

    trait :no_topo do
      topo nil
    end
  end

end
