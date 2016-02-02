class User < ActiveRecord::Base

  # ----------------------------------------------------------------------------
  # Rolify
  # ----------------------------------------------------------------------------
  rolify after_add: :rolify_after_add
  def rolify_after_add(role)
    self.update(current_role: role.name) if self.current_role.blank?
    self.try "create_#{role.name}_story"
  end

  # For an explaination, see
  # http://stackoverflow.com/questions/4470108/when-monkey-patching-a-method-can-you-call-the-overridden-method-from-the-new-i/4471202#4471202
  old_add_role = instance_method(:add_role)
  define_method(:add_role) do |role_name, resource = nil|
    if Role.defined_roles.include?(role_name.to_s)
      old_add_role.bind(self).(role_name, resource)
      return nil
    else
      return "The role '#{role_name}' was not added for #{address_me_as} because the role is not defined."
    end
  end
  alias grant add_role # otherwise grant refers to the old one

  # ----------------------------------------------------------------------------
  # Devise
  # ----------------------------------------------------------------------------
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # ----------------------------------------------------------------------------
  # Name
  # ----------------------------------------------------------------------------
  has_one :name, dependent: :destroy
  accepts_nested_attributes_for :name

  class Name < ActiveRecord::Base
    belongs_to :user
  end

  def address_me_as
    if name
      name.first.blank? ? email : name.first
    else
      email
    end
  end

  # ----------------------------------------------------------------------------
  # Address
  # ----------------------------------------------------------------------------
  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address

  # ----------------------------------------------------------------------------
  # Setter Story
  # ----------------------------------------------------------------------------
  has_one :setter_story

  # ----------------------------------------------------------------------------
  # Athlete Story
  # ----------------------------------------------------------------------------
  has_one :athlete_story

end
