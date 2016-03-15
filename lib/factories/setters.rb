FactoryGirl.define do
  factory :_setter_, parent: :setter do
    transient do
      setter_climb_logs_count { Faker::Number.between(0, 30) }
    end
  end
end
