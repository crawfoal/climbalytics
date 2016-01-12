class BoulderPolicy < ApplicationPolicy
  alias_method :boulder, :record
  def new?
    user.has_role? :setter
  end
  def create?
    new? and boulder.setter == user
  end
  def update?
    boulder.setter == user
  end
  def destroy?
    update?
  end
end
