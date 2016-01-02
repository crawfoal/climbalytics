class Address < ActiveRecord::Base

  validates_presence_of :line1, :city, :state_id
  validates :zip, length: { is: 5 }, numericality: { only_integer: true }

  belongs_to :state
  belongs_to :addressable, polymorphic: true

end
