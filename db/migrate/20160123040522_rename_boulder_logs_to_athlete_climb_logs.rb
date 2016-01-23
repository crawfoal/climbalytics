class RenameBoulderLogsToAthleteClimbLogs < ActiveRecord::Migration
  def change
    rename_table :boulder_logs, :athlete_climb_logs
  end
end
