FactoryGirl.define do
  factory :user do
    email                 'amanda@example.com'
    password              'password'
    password_confirmation { |u| u.password }
  end
  factory :name, class: User::Name do
    first       'Amanda'
    last        'Dolan'
    user
  end
end
