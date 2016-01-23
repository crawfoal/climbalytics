class AthleteClimbLog < ActiveRecord::Base

  belongs_to :setter_climb_log

  belongs_to :athlete_story
  def athlete
    athlete_story.user if athlete_story
  end

  has_one :climb, as: :loggable

end
