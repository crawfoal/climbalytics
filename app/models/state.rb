class State < ActiveRecord::Base
  # has_many :addresses, as: :addressable # could include this at some point if I
  #                                       # need to get a list of all users in a
  #                                       # particular state

  generate_validations_for :postal_abbreviation, :full_name
end
