class Gym < ActiveRecord::Base
  has_one :location, as: :locateable, dependent: :destroy
  validates :location, presence: true

  generate_validations_for :name, :topo
end
