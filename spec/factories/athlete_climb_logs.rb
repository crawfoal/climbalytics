FactoryGirl.define do
  factory :athlete_climb_log do
    athlete_story
    association :climb, factory: [:boulder, :route].sample
  end

end
