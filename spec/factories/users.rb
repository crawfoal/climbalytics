FactoryGirl.define do
  factory :user do
    sequence :email do |number|
      "amanda#{number}@example.com"
    end
    password              'password'
    password_confirmation { |u| u.password }
    factory :athlete_user do
      sequence :email do |number|
        "athlete#{number}@example.com"
      end
      after(:create) do |user|
        err_msg = user.add_role(:athlete)
        puts err_msg.red unless err_msg.blank? if err_msg
      end
    end
    factory :setter_user do
      sequence :email do |number|
        "setter#{number}@example.com"
      end
      after(:create) do |user|
        err_msg = user.add_role(:setter)
        puts err_msg.red unless err_msg.blank? if err_msg
      end
    end
  end
  factory :name, class: User::Name do
    first       'Amanda'
    last        'Dolan'
    user
  end
  factory :athlete_name, class: User::Name do
    first       'Annie'
    last        'Athlete'
    association :user, factory: :athlete_user
  end
  factory :setter_name, class: User::Name do
    first       'Sam'
    last        'Setter'
    association :user, factory: :setter_user
  end
end
