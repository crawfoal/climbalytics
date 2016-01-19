class BoulderLogPolicy < ApplicationPolicy
  alias_method :boulder_log, :record
  def show?
    boulder_log.athlete == user
  end
  def new?
    user.has_role? :athlete
  end
  def create?
    new? and boulder_log.athlete == user
  end
  def edit?
    show?
  end
  def update?
    show?
  end
  def destroy?
    show?
  end
end
