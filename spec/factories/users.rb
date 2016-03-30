FactoryGirl.define do

  factory :user do

    transient do
      roles []
      gym nil
    end

    trait :with_name do
      name
    end

    before(:create) do |user, evaluator|
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
          create_list(
            evaluator.athlete_climb_log_factory,
            evaluator.athlete_climb_logs_count,
            gym: evaluator.gym,
            athlete_story: user.athlete_story
          )
        end
      end
    end

    factory :setter do
      transient do
        roles [:setter]
        setter_climb_logs_count 0
        setter_climb_log_factory :setter_climb_log
      end

      after(:create) do |user, evaluator|
        if evaluator.setter_climb_logs_count > 0
          create_list(
            evaluator.setter_climb_log_factory,
            evaluator.setter_climb_logs_count,
            gym: evaluator.gym,
            setter_story: user.setter_story
          )
        end
      end
    end
  end

  factory :name, class: User::Name do
    first       { Faker::Name.first_name }
    last        { Faker::Name.last_name }
  end
end
