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

end
