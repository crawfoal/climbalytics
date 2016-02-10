class ClimbSesh < ActiveRecord::Base
  belongs_to :athlete_climb_log
  validates_presence_of :athlete_climb_log

  generate_validations_for :high_hold, :note
end
