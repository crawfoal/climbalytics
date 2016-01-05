class User < ActiveRecord::Base

  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Settings for the user's name.
  has_one :name, dependent: :destroy
  accepts_nested_attributes_for :name

  class Name < ActiveRecord::Base

    belongs_to :user

  end

  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address

end
