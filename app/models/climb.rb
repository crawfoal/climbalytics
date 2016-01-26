class Climb < ActiveRecord::Base
  belongs_to :loggable, polymorphic: true
  validates_presence_of :type
end
