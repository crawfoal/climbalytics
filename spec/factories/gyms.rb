FactoryGirl.define do
  factory :gym do

    transient do
      location_factory :location
    end

    name { Faker::Company.name }
    topo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'gyms', 'topo_image.png')) }

    after(:build) do |gym, evaluator|
      gym.location = build(evaluator.location_factory)
    end

    trait :invalid do
      name nil
      topo nil
      location nil
    end

    factory :wild_walls do
      name 'Wild Walls'
      transient do
        location_factory :ww_location
      end
      after :create do |gym|
        Faker::Number.between(1,5).times { gym.sections << create(:gym_section) }
      end
    end
  end
end
