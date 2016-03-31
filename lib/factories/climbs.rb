FactoryGirl.define do
  factory :_climb_, parent: :climb do
    grade do
      Sometimes.four_fifths_of_the_time { type.constantize.grades.keys.sample }
    end
    moves_count do
      Sometimes.four_fifths_of_the_time { Faker::Number.between(1, 30) }
    end
    name do
      Sometimes.a_fifth_of_the_time { Faker::Hipster.words(Faker::Number.between(1,5)).join(' ').titlecase }
    end

    transient do
      gym_factory :_gym_
    end
  end
end
