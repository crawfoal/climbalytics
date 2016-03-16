class User < ActiveRecord::Base

  belongs_to :user_account
  delegate :email, to: :user_account
  alias_method :account, :user_account

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
  # Name
  # ----------------------------------------------------------------------------
  has_one :name, dependent: :destroy
  accepts_nested_attributes_for :name

  class Name < ActiveRecord::Base
    belongs_to :user
    generate_validations_for :first, :last

    def short_format
      first unless first.blank?
    end
  end

  def address_me_as
    name.try(:short_format) || email
  end

  # ----------------------------------------------------------------------------
  # Setter Story
  # ----------------------------------------------------------------------------
  has_one :setter_story

  # ----------------------------------------------------------------------------
  # Athlete Story
  # ----------------------------------------------------------------------------
  has_one :athlete_story

  # ----------------------------------------------------------------------------
  # Current Location
  # ----------------------------------------------------------------------------
  has_one :current_location, as: :locateable, class_name: 'Location', dependent: :destroy
  accepts_nested_attributes_for :current_location

  def recent_gyms
    if current_role == 'athlete'
      alogs = athlete_story.athlete_climb_logs.order(created_at: :desc, id: :asc).limit(25)
      gyms = alogs.map{ |alog| alog.climb.gym }.uniq
      gyms = gyms[0..([2, gyms.length].min)]
    else # will implement setter version later
      return nil
    end
  end

  generate_validations_for :current_role
end
