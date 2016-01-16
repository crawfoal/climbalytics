class SetterStory < ActiveRecord::Base
  belongs_to :user
  has_many :boulders
end
