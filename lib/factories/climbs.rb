FactoryGirl.define do
  factory :_climb_, parent: :climb do
    grade do
      four_fifths_of_the_time { type.constantize.grades.keys.sample }
    end
    moves_count do
      four_fifths_of_the_time { Faker::Number.between(1, 30) }
    end
    name do
      a_fifth_of_the_time { Faker::Hipster.words(Faker::Number.between(1,5)).join(' ').titlecase }
    end

    transient do
      gym do
        if loggable_type == 'AthleteClimbLog'
          athlete_climb_log.athlete_story.athlete_climb_logs.sample.try(:climb).try(:gym) or
          Gym.random or
          create(:_gym_)
        else
          Gym.random or create(:_gym_)
        end
      end
    end

    after :build do |climb, evaluator|
      climb.gym_section = evaluator.gym.sections.sample
    end
  end
end
