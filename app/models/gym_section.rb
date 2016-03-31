class GymSection < ActiveRecord::Base
  belongs_to :gym

  has_many :climbs, -> { where loggable_type: 'SetterClimbLog' }

  validates_presence_of :name
end
