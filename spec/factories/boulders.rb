FactoryGirl.define do
  boulder_problems = {'The Pearl': 'V5', 'The Pork Chop': 'V2', 'Midnight Lightning': 'V8', 'Slider': 'V9', 'Soulslinger': 'V9', 'The Wind Below': 'V8', 'Whispers of Wisom': 'V10'}
  factory :boulder do
    sequence(:name, boulder_problems.keys.cycle.each)
    grade { boulder_problems[name] }
  end
end
