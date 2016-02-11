class Location < ActiveRecord::Base
  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address

  belongs_to :locateable, polymorphic: true

  generate_validations_for :name
end
