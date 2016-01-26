class AthleteClimbLog < ActiveRecord::Base

  # enum grade: (["VB"] + ((0..16).to_a.map {|num| "V#{num}"}))

  belongs_to :setter_climb_log

  belongs_to :athlete_story
  def athlete
    athlete_story.user if athlete_story
  end

end