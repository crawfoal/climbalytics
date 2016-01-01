class Address < ActiveRecord::Base

  validates_presence_of :line1, :city, :state, :zip
  validates :zip, numericality: { only_integer: true }

  belongs_to :state
  belongs_to :addressable, polymorphic: true

end
