class Climb < ActiveRecord::Base
  belongs_to :loggable, polymorphic: true
  validates_presence_of :type

  belongs_to :gym_section

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
