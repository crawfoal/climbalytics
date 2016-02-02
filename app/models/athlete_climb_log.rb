class AthleteClimbLog < ActiveRecord::Base

  extend StiChooseable

  belongs_to :setter_climb_log

  belongs_to :athlete_story
  validates_presence_of :athlete_story
  def athlete
    athlete_story.user if athlete_story
  end

  has_one :climb, as: :loggable, dependent: :destroy
  accepts_nested_attributes_for :climb
  sti_chooseable :climb, :boulder, :route

  has_many :climb_seshes, dependent: :destroy

end
