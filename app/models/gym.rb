class Gym < ActiveRecord::Base
  has_one :location, as: :locateable, dependent: :destroy
  accepts_nested_attributes_for :location
  validates_presence_of :location

  has_many :gym_sections, dependent: :destroy
  accepts_nested_attributes_for :gym_sections, reject_if: :all_blank, allow_destroy: true

  mount_uploader :topo, TopoUploader
  validates :topo, presence: true

  generate_validations_for :name
end
