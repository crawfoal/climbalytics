class Location < ActiveRecord::Base
  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address
  delegate :geocode_format, to: :address, prefix: true
  geocoded_by :address_geocode_format
  after_validation :geocode, if: -> { address.present? and address.changed? }

  belongs_to :locateable, polymorphic: true

  validates_numericality_of :latitude, :longitude, allow_nil: true
end
