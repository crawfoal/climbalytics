FactoryGirl.define do
  factory :athlete_story do
    association :user, factory: :athlete
  end

end
