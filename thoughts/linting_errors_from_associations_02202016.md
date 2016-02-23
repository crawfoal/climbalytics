# The Error

When FactoryGirl lints my factories, I get the following error:

```
* generic_address - Validation failed: Addressable has already been taken (ActiveRecord::RecordInvalid)
* generic_location - Validation failed: Addressable has already been taken (ActiveRecord::RecordInvalid)
```

# The Background

I have a `Location` model and an `Address` model, which are associated via a polymorphic relationship, and the `Address` model has a uniqueness validation for the polymorphic association:

```ruby
# app/models/location.rb
class Location < ActiveRecord::Base
  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address

  # more code dealing with geocoding and a locateable polymorphic relationship
end
```

```ruby
# app/models/address.rb
class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic

  # There is also a unique index on the two columns
  validates :addressable_id, uniqueness: { scope: :addressable_type }

  # more code validating fields of the address, and helper functions
  # for formatting and determining if a record should be considered
  # blank
end
```

I have base case factories for these two models:

```ruby
# spec/factories/locations.rb
FactoryGirl.define do
  factory :location do

    # will get latitutde and longitude from default stub
    trait :with_address do
      address
    end
  end
end
```

```ruby
# spec/factories/addresses.rb
FactoryGirl.define do
  factory :address do
    line1         Faker::Address.street_address
    city          Faker::Address.city
    state
    zip           Faker::Address.zip.to_i
  end
end
```

and then I have a set of more specialized factories:

```ruby
# lib/data_generators/factories/locations.rb
FactoryGirl.define do
  factory :generic_location, class: Location do
    association :address, factory: :generic_address
  end
end
```

```ruby
# lib/data_generators/factories/addresses.rb
FactoryGirl.define do
  factory :generic_address, class: Address do
    line1 '123 Main St.'
    city  'Somewhere'
    association :state, factory: :generic_state
    zip   '00000'
  end
end
```

# The Solution
The first error (on `:generic_address`) was because the validation need to have the `allow_nil: true` option, otherwise only one plain address can be created (that is an address which isn't associated to anything).

The second error (on `:generic_location`) was also solved by this, however before I did the above fixed, I had tried adding `strategy: :build` on the address association in the factory definition for `:generic_location`. This had solved the error on the `:generic_location` factory, but it solved a symptom of the real issue (which is the one above).
