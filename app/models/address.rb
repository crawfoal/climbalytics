class Address < ActiveRecord::Base

  with_options unless: :blank? do |address|
    address.validates_presence_of :line1, :city, :state_id
    address.validates :zip, length: { is: 5 }, numericality: { only_integer: true }
  end

  belongs_to :state
  belongs_to :addressable, polymorphic: true

  def format
    "#{line1}\n"\
    "#{line2}\n"\
    "#{city}, #{state.postal_abbreviation} #{zip}"
  end

  def blank?
    [:line1, :line2, :city, :state, :zip].all? { |attrib| self.send(attrib).blank? }
  end

end
