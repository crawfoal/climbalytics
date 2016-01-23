FactoryGirl.define do
  factory :climb do
    name "bad climb - no type"
    moves_count 1
    association :loggable, factory: :athlete_climb_log
    factory :boulder do
      type 'Boulder'
      grade 'V5'
    end
    factory :route do
      type 'Route'
      grade '5.10b'
    end
  end

end
