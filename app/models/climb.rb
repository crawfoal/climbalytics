class Climb < ActiveRecord::Base
  belongs_to :loggable, polymorphic: true
  validates_presence_of :type

  belongs_to :gym_section

  generate_validations_for :name, :moves_count
end
