class User < ActiveRecord::Base

  # ----------------------------------------------------------------------------
  # Rolify
  # ----------------------------------------------------------------------------
  rolify after_add: :rolify_after_add
  def rolify_after_add(role)
    self.current_role = role.name unless self.roles.count > 1
  end

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

  # ----------------------------------------------------------------------------
  # Address
  # ----------------------------------------------------------------------------
  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address

end
