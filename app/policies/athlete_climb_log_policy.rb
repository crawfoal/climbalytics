class AthleteClimbLogPolicy < ApplicationPolicy
  alias_method :athlete_climb_log, :record
  def show?
    athlete_climb_log.athlete == user
  end
  def new?
    user.has_role? :athlete
  end
  def create?
    new? and athlete_climb_log.athlete == user
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
