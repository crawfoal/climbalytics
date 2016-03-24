class AthleteStory < ActiveRecord::Base

  belongs_to :user
  validates_presence_of :user

  has_many :athlete_climb_logs

  #-----------------------------------------------------------------------------
  # Cache 3 most recently visited gyms
  #  > caching is triggered by AthleteClimbLogObserver
  #  > I didn't actually measure performance and verify this is faster than the alternatives. You could define a `has_many :through` association and then grab all of the gyms (order by date the climb records were created), remove the duplicates (but only the *consequitive duplicates*), and then grab the three most recent. This seems like a pretty expensive operation to me. You would only do this expensive operation when looking up the recent gyms, whereas with the current implementation, we are asking "Has the most recent gym changed?" *every time* a user logs a climb, and I'm pretty sure the answer will be no most of the time (but that does depend on how the user uses the application).
  serialize :recent_gym_ids_cache, Array

  def cache_recent_gym(id_or_obj)
    gym_id = id_or_obj.try(:id) || id_or_obj

    unless recent_gym_ids_cache.first == gym_id
      recent_gym_ids_cache.pop if recent_gym_ids_cache.size > 2
      recent_gym_ids_cache.unshift(gym_id)
      save
    end

    return recent_gym_ids_cache
  end
  validate do
    recent_gym_ids_cache.each do |gym_id|
      unless gym_id.is_a? Integer
        errors.add(:recent_gym_ids_cache, 'Each element of recent_gym_ids_cache must be an integer')
      end
    end
  end

  # or maybe we should just cache the whole gym record...
  def recent_gyms
    recent_gym_ids_cache.blank? ? [] : Array(Gym.find(*recent_gym_ids_cache)).index_by(&:id).values_at(*recent_gym_ids_cache)
  end
  #-----------------------------------------------------------------------------

end
