class State < ActiveRecord::Base
  # has_many :addresses, as: :addressable # could include this at some point if I
  #                                       # need to get a list of all users in a
  #                                       # particular state
  validates_length_of :postal_abbreviation, maximum: 2
  validates_length_of :full_name, maximum: 50
end
