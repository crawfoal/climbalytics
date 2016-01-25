class ClimbSesh < ActiveRecord::Base
  belongs_to :athlete_climb_log
  validates_presence_of :athlete_climb_log
end
