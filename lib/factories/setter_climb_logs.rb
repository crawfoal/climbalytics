FactoryGirl.define do
  factory :_setter_climb_log_, parent: :setter_climb_log do
    picture do
      Sometimes.a_fourth_of_the_time do
        Rack::Test::UploadedFile.new(
          "#{Rails.root}/public/uploads/boulder/picture/1/AmandaGreatWhiteBehemoth.jpg"
        )
      end
    end

    transient do
      climb_factory :_climb_
    end
  end
end
