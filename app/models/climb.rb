class Climb < ActiveRecord::Base
  include Searchable

  belongs_to :loggable, polymorphic: true
  validates_presence_of :type
  scope :with_type, -> (type) { where loggable_type: type }

  belongs_to :gym_section
  # For now, only define the getter method for the associated gym; not using a `has_one :through` association because it doesn't make sense to create/build a gym from an instance of a climb. At some point, we might want to define a setter method as well, but there is no use case yet.
  def gym
    gym_section.try(:gym)
  end
  scope :in_section, -> (section) { where gym_section: section }
  class << Climb
    alias_method :in_sections, :in_section # can also pass in array of sections
  end
  scope :in_gym, -> (gym) do
    _gym = Gym.find_by id: gym unless gym.respond_to? :sections
    in_sections (_gym or gym).sections
  end
  validates_presence_of :gym_section

  def grade
    unless type.blank?
      type.constantize.grades.key(read_attribute(:grade))
    else
      read_attribute(:grade)
    end
  end

  def grade=(value)
    if value.is_a? String and not type.blank?
      write_attribute(:grade, type.constantize.grades[value])
    else
      write_attribute(:grade, value)
    end
  end

  def value_attribute_names
    [
      'grade',
      'name',
      'moves_count',
      'type',
      'gym_section_id'
    ]
  end

  def value_attributes
    attributes.slice(*value_attribute_names)
  end

  validates :moves_count, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  generate_validations_for :name
end
