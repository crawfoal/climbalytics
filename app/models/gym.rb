class Gym < ActiveRecord::Base
  has_one :location, as: :locateable, dependent: :destroy
  accepts_nested_attributes_for :location
  validates_presence_of :location

  mount_uploader :topo, TopoUploader
  validates :topo, presence: true

  generate_validations_for :name
end
