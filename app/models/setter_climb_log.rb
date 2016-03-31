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

  #-----------------------------------------------------------------------------
  # Climbs
  #-----------------------------------------------------------------------------
  has_one :climb, as: :loggable, dependent: :destroy
  accepts_nested_attributes_for :climb
  validates_presence_of :climb

  validates_length_of :note, maximum: 20000
end
