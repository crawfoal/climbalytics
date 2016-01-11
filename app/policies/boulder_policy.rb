class BoulderPolicy < ApplicationPolicy
  def create?
    user.has_role? :setter and record.setter == user
  end
  def update?
    record.setter == user
  end
  def destroy?
    update?
  end
end
