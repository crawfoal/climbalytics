FactoryGirl.define do
  factory :user do
    email                 'amanda@example.com'
    password              'password'
    password_confirmation { |u| u.password }
    factory :athlete_user do
      email 'athlete@example.com'
      after(:create) do |user|
        err_msg = user.add_role(:athlete)
        puts err_msg.red unless err_msg.blank? if err_msg
      end
    end
    factory :setter_user do
      email 'setter@example.com'
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
