FactoryGirl.define do
  factory :setter_climb_log do
    note { Faker::Hipster.sentence } # delete this once we have at least one requried attribute for a setter_climb_log (this shouldn't be here since it isn't a requried attribute for the model, but we need something to be defined in order for the POST_create spec to work)

    transient do
      climb_factory { [:boulder, :route].sample }
    end

    before :create do |setter_climb_log, evaluator|
      setter_climb_log.climb = create(evaluator.climb_factory)
    end
  end
end
