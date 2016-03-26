class ClimbSesh < ActiveRecord::Base
  belongs_to :athlete_climb_log
  validates_presence_of :athlete_climb_log
  validates_numericality_of :high_hold, only_integer: true, allow_nil: true
  validates_length_of :note, maximum: 20000
end
