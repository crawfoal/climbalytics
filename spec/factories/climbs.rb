FactoryGirl.define do
  factory :climb do
    type ['Boulder', 'Route'].sample
    
    factory :boulder do
      type  'Boulder'
    end
    factory :route do
      type  'Route'
    end
  end

end
