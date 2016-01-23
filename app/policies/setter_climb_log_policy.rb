class SetterClimbLogPolicy < ApplicationPolicy
  alias_method :setter_climb_log, :record
  def new?
    user.has_role? :setter
  end
  def create?
    new? and setter_climb_log.setter == user
  end
  def update?
    setter_climb_log.setter == user
  end
  def destroy?
    update?
  end
end
