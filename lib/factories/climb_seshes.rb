FactoryGirl.define do
  factory :_climb_sesh_, parent: :climb_sesh do
    high_hold do
      four_fifths_of_the_time { Faker::Number.between(0,30) }
    end
    note do
      a_fifth_of_the_time { Faker::Hipster.paragraph(1, false, 3) }
    end
  end
end
