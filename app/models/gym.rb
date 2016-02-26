class Gym < ActiveRecord::Base
  has_one :location, as: :locateable, dependent: :destroy
  accepts_nested_attributes_for :location
  validates_presence_of :location
  def self.near(*args)
    Location.where(locateable_type: 'Gym').near(*args).map { |location| location.locateable }
  end

  has_many :gym_sections, dependent: :destroy
  accepts_nested_attributes_for :gym_sections, reject_if: :all_blank, allow_destroy: true
  alias_method :sections, :gym_sections

  mount_uploader :topo, TopoUploader
  validates :topo, presence: true

  generate_validations_for :name
end
