FactoryGirl.define do
  factory :gym do
    name Faker::Company.name
    topo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'gyms', 'topo_image.png')) }
    location

    trait :invalid do
      name nil
      topo nil
      location nil
    end
  end

end
