FactoryGirl.define do
  factory :gym do
    name "MyString"
    topo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'gyms', 'topo_image.png')) }
    location

    trait :no_name do
      name nil
    end

    trait :no_topo do
      topo nil
    end
  end

end
