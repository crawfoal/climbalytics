FactoryGirl.define do

  factory :user do
    transient do
      roles []
    end

    trait :with_name do
      name
    end

    after(:build) do |user, evaluator|
      user.user_account = create(:user_account, roles: evaluator.roles)
    end

    after(:create) do |user, evaluator|
      evaluator.roles.each do |role|
        err_msg = user.add_role(role)
        puts err_msg.red unless err_msg.blank? if err_msg
      end
    end

    factory :athlete do
      transient do
        roles                     [:athlete]
        athlete_climb_logs_count  0
        athlete_climb_log_factory :athlete_climb_log
      end

      after(:create) do |user, evaluator|
        if evaluator.athlete_climb_logs_count > 0
          create_list(evaluator.athlete_climb_log_factory, evaluator.athlete_climb_logs_count, athlete_story: user.athlete_story)
        end
      end
    end

    factory :setter do
      transient do
        roles [:setter]
        setter_climb_logs_count 0
      end

      after(:create) do |user, evaluator|
        if evaluator.setter_climb_logs_count > 0
          create_list(:setter_climb_log, evaluator.setter_climb_logs_count, setter_story: user.setter_story)
        end
      end
    end
  end

  factory :name, class: User::Name do
    first       { Faker::Name.first_name }
    last        { Faker::Name.last_name }
  end
end
