FactoryGirl.define do
  factory :climb do
    name        "bad climb - no type"
    moves_count 1
    association :loggable, factory: :athlete_climb_log
    factory :boulder do
      name  'The Pearl'
      type  'Boulder'
      grade 'V5'
    end
    factory :route do
      name  'Balance Beam'
      type  'Route'
      grade '5.11a'
    end
  end

end
