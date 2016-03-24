FactoryGirl.define do
  factory :gym do

    transient do
      location_factory :location
      num_sections 1
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

    trait :with_standard_sections do
      transient do
        num_sections 0
      end
      after :build do |gym|
        [
          'Slab',
          'Gentle overhang',
          'The vert',
          'The 45',
          'The cave',
        ].each do |name|
          gym.sections << create(:gym_section, name: name)
        end
      end
    end

    factory :wild_walls do
      name 'Wild Walls'
      transient do
        location_factory :ww_location
      end
      with_standard_sections
      after :build do |gym|
        [
          'Back wall',
          'Left of the cave',
          'Setter cave exterior'
        ].each do |name|
          gym.sections << create(:gym_section, name: name)
        end
      end
    end

    factory :brooklyn_boulders_ny do
      name 'Brooklyn Boulders NY'
      transient do
        location_factory :bb_ny_location
      end
      with_standard_sections
    end

    factory :the_front_salt_lake do
      name 'The Front Climbing Club'
      transient do
        location_factory :front_sc_location
      end
      with_standard_sections
    end
  end
end
