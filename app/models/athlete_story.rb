class AthleteStory < ActiveRecord::Base
  belongs_to :user
  has_many :athlete_climb_logs
end
