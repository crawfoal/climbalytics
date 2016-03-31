class AddRecentGymIdsCacheToAthleteStories < ActiveRecord::Migration
  def change
    add_column :athlete_stories, :recent_gym_ids_cache, :text
  end
end
