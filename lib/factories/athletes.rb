FactoryGirl.define do
  factory :_athlete_, parent: :athlete do
    transient do
      athlete_climb_logs_count { Faker::Number.between(0, 30) }
      athlete_climb_log_factory :_athlete_climb_log_
    end
  end
end
