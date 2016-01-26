FactoryGirl.define do
  factory :athlete_climb_log do
    quality_rating 5
    note "I love this boulder problem!"
    project false
    athlete_story
  end

end
