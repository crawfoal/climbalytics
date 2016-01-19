class AthleteStory < ActiveRecord::Base
  belongs_to :user
  has_many :boulder_logs
end
