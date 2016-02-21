FactoryGirl.define do
  factory :gym do

    transient do
      location_factory :location
    end

    name Faker::Company.name
    topo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'gyms', 'topo_image.png')) }

    after(:build) do |gym, evaluator|
      gym.location = build(evaluator.location_factory)
    end

    trait :invalid do
      name nil
      topo nil
      location nil
    end
  end

end
