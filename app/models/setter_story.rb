class SetterStory < ActiveRecord::Base
  belongs_to :user
  has_many :setter_climb_logs
end
