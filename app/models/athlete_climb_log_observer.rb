class AthleteClimbLogObserver < ActiveRecord::Observer
  def after_save(athlete_climb_log)
    athlete_climb_log.athlete_story.cache_recent_gym(athlete_climb_log.gym)
  end
end
