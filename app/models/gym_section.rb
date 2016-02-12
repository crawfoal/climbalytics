class GymSection < ActiveRecord::Base
  belongs_to :gym

  has_many :climbs, -> { where loggable_type: 'SetterClimbLog' }

  generate_validations_for :name
end
