FactoryGirl.define do
  factory :gym do

    transient do
      location_factory :location
      num_sections 0
      sections_factory :gym_section
    end

    name { Faker::Company.name }
    topo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'gyms', 'topo_image.png')) }

    after(:build) do |gym, evaluator|
      gym.location = build(evaluator.location_factory)

      gym.sections << create_list(evaluator.sections_factory, evaluator.num_sections)
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
        [
          'Slab',
          'Back wall',
          'Gentle overhang',
          'The vert',
          'The 45',
          'The cave',
          'Left of the cave',
          'Setter cave exterior'
        ].each do |name|
          gym.sections << create(:gym_section, name: name)
        end
      end
    end
  end
end
