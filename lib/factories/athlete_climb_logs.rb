FactoryGirl.define do
  factory :_athlete_climb_log_, parent: :athlete_climb_log do
    note do
      Sometimes.a_fifth_of_the_time { Faker::Hipster.paragraph(1, false, 3) }
    end
    project do
      Sometimes.four_fifths_of_the_time {Sometimes.two_thirds_of_the_time ? true : false }
    end
    quality_rating do
      Sometimes.a_third_of_the_time do
        Faker::Number.between(
          AthleteClimbLog.min_quality_rating,
          AthleteClimbLog.max_quality_rating
        )
      end
    end

    transient do
      climb_seshes_count { Faker::Number.between(1, 10) }
      climb_sesh_factory :_climb_sesh_
      climb_factory :_climb_
      setter_climb_log_factory :_setter_climb_log_
    end

    after :build do |alog, evaluator|
      alog.setter_climb_log = create evaluator.setter_climb_log_factory, gym_section: evaluator.gym_section
    end
  end
end
