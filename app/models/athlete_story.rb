class AthleteStory < ActiveRecord::Base

  belongs_to :user
  validates_presence_of :user

  has_many :athlete_climb_logs

end
