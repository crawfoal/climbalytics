FactoryGirl.define do
  factory :athlete_climb_log do
    #---------------------------------------------------------------------------
    # Default Attributes
    athlete_story

    transient do
      climb_factory { [:boulder, :route].sample }
    end

    before(:create) do |athlete_climb_log, evaluator|
      athlete_climb_log.climb = FactoryGirl.create(evaluator.climb_factory)
    end
    #---------------------------------------------------------------------------

    transient do
      climb_seshes_count 0
      climb_sesh_factory :climb_sesh
    end

    after(:create) do |athlete_climb_log, evaluator|
      if evaluator.climb_seshes_count > 0
        create_list(evaluator.climb_sesh_factory, evaluator.climb_seshes_count, athlete_climb_log: athlete_climb_log)
      end
    end
  end

end
