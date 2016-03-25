FactoryGirl.define do
  factory :_user_, parent: :user do
    after :build do |user, evaluator|
      half_of_the_time { user.name = create(:name) }
    end
  end
end
