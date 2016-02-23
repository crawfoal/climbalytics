FactoryGirl.define do
  factory :gym_section do
    name { Faker::Hipster.sentence(1, false, 3).tr('.', '') }
  end

end
