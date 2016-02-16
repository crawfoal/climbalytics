FactoryGirl.define do

  sequence(:user_number) { |n| n }
  sequence(:athlete_number) { |n| n }
  sequence(:setter_number) { |n| n }

  factory :user do
    transient do
      user_number         { generate(:user_number) }
      athlete_number      { generate(:athlete_number) }
      setter_number       { generate(:setter_number) }
    end

    email                 { "user#{user_number}@example.com" }
    password              { "password#{user_number}" }
    password_confirmation { |u| u.password }

    trait :with_name do
      name
    end

    factory :athlete_user do
      email {"athlete#{user_number}@example.com"}

      after(:create) do |user|
        err_msg = user.add_role(:athlete)
        puts err_msg.red unless err_msg.blank? if err_msg
      end
    end
    factory :setter_user do
      email { "setter#{user_number}@example.com" }

      after(:create) do |user|
        err_msg = user.add_role(:setter)
        puts err_msg.red unless err_msg.blank? if err_msg
      end
    end
  end

  factory :name, class: User::Name do
    first       Faker::Name.first_name
    last        Faker::Name.last_name
  end
end
