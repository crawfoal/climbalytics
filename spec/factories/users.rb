FactoryGirl.define do
  factory :user do
    email                 'amanda@example.com'
    password              'password'
    password_confirmation { |u| u.password }
    factory :athlete_user do
      email 'athlete@example.com'
      after(:create) {|user| user.add_role(:athlete)}
    end
    factory :setter_user do
      email 'setter@example.com'
      after(:create) {|user| user.add_role(:setter)}
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
