class BoulderPolicy < ApplicationPolicy
  alias_method :boulder, :record
  def create?
    user.has_role? :setter and boulder.setter == user
  end
  def update?
    boulder.setter == user
  end
  def destroy?
    update?
  end
end
