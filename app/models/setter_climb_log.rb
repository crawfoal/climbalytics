class SetterClimbLog < ActiveRecord::Base

  #-----------------------------------------------------------------------------
  # Pictures
  #-----------------------------------------------------------------------------
  mount_uploader :picture, PictureUploader

  #-----------------------------------------------------------------------------
  # Setter
  #-----------------------------------------------------------------------------
  belongs_to :setter_story

  def setter
    setter_story.user if setter_story
  end

  #-----------------------------------------------------------------------------
  # Athlete Climb Logs
  #-----------------------------------------------------------------------------
  has_many :athlete_climb_logs

  generate_validations_for :note
end
