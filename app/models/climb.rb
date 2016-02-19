class Climb < ActiveRecord::Base
  belongs_to :loggable, polymorphic: true
  validates_presence_of :type

  belongs_to :gym_section

  validates :moves_count, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  generate_validations_for :name
end
