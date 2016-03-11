class Climb < ActiveRecord::Base
  belongs_to :loggable, polymorphic: true
  validates_presence_of :type

  belongs_to :gym_section
  # For now, only define the getter method for the associated gym; not using a `has_one :through` association because it doesn't make sense to create/build a gym from an instance of a climb. At some point, we might want to define a setter method as well, but there is no use case yet.
  def gym
    gym_section.try(:gym)
  end

  def grade
    unless type.blank?
      type.constantize.grades.key(read_attribute(:grade))
    else
      read_attribute(:grade)
    end
  end

  validates :moves_count, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  generate_validations_for :name
end
