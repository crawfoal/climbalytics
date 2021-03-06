class AthleteClimbLog < ActiveRecord::Base

  belongs_to :setter_climb_log

  belongs_to :athlete_story
  validates_presence_of :athlete_story
  def athlete
    athlete_story.user if athlete_story
  end
  delegate :gym, to: :climb

  has_one :climb, as: :loggable, dependent: :destroy
  accepts_nested_attributes_for :climb
  validates_presence_of :climb

  has_many :climb_seshes, dependent: :destroy, inverse_of: :athlete_climb_log
  accepts_nested_attributes_for :climb_seshes, allow_destroy: true

  validates :quality_rating, numericality: { only_integer: true,
                                             greater_than: 0,
                                             less_than: 6 }, allow_nil: true
  def self.min_quality_rating
    validators_on(:quality_rating).each do |validator|
      if validator.kind == :numericality
          return validator.options[:greater_than] + 1
      end
    end
  end
  def self.max_quality_rating
    validators_on(:quality_rating).each do |validator|
      if validator.kind == :numericality
          return validator.options[:less_than] - 1
      end
    end
  end

  validates_length_of :note, maximum: 20000

end
