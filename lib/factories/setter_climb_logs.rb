FactoryGirl.define do
  factory :_setter_climb_log_, parent: :setter_climb_log do
    picture do
      a_fourth_of_the_time { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public', 'uploads', 'boulder', 'picture', '1', 'AmandaGreatWhiteBehemoth.jpg')) }
    end

    transient do
      climb_factory :_climb_
    end
  end
end
