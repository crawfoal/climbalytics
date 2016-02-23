FactoryGirl.define do

  # Initial value is just for when we're playing around in the terminal and there are already some users defined.
  sequence(:user_number, User.count + 1) { |n| n }

  factory :user do
    transient do
      roles []

      user_number do
        generate(:user_number)
      end

      email_prefix do
        if roles.empty?
          'user'
        else
          roles.join
        end
      end
    end

    #---------------------------------------------------------------------------
    # Default Attributes
    email                 { "#{email_prefix}#{user_number}@example.com" }
    password              { "password#{user_number}" }
    password_confirmation { |u| u.password }
    #---------------------------------------------------------------------------

    trait :with_name do
      name
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
