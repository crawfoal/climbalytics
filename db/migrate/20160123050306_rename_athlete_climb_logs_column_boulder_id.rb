class RenameAthleteClimbLogsColumnBoulderId < ActiveRecord::Migration
  def change
    rename_column :athlete_climb_logs, :boulder_id, :setter_climb_log_id
  end
end
