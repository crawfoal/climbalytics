class Address < ActiveRecord::Base

  with_options unless: :blank? do |address|
    address.validates_presence_of :line1, :city, :state
    address.validates :zip, length: { is: 5 }, numericality: { only_integer: true }
  end

  belongs_to :state
  belongs_to :addressable, polymorphic: true

  def post_office_format
    "#{line1}\n"\
    "#{line2}\n"\
    "#{city}, #{state.postal_abbreviation} #{zip}"
  end

  def geocode_format
    [line1, line2, city, state.postal_abbreviation, zip].compact.join(', ')
  end

  def blank?
    [:line1, :line2, :city, :state, :zip].all? { |attrib| self.send(attrib).blank? }
  end

  generate_validations_for :line1, :line2, :city, :zip, :state_id, :addressable_id

end
