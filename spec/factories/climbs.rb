FactoryGirl.define do
  factory :climb do
    type { ['Boulder', 'Route'].sample }

    transient do
      gym_factory :gym
      gym do
        if loggable_type == 'AthleteClimbLog'
          athlete_climb_log.athlete_story.athlete_climb_logs.sample.try(:climb).try(:gym) or
          Gym.random or
          create(gym_factory)
        else
          Gym.random or create(gym_factory)
        end
      end
    end

    after :build do |climb, evaluator|
      climb.gym_section = evaluator.gym.sections.sample unless climb.gym_section
    end

    factory :boulder do
      type  'Boulder'
    end
    factory :route do
      type  'Route'
    end
  end

end
