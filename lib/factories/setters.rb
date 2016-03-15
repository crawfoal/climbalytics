FactoryGirl.define do
  factory :_setter_, parent: :setter do
    transient do
      setter_climb_logs_count { Faker::Number.between(0, 30) }
      setter_climb_log_factory :_setter_climb_log_
    end
  end
end
