class RenameBouldersToSetterClimbLogs < ActiveRecord::Migration
  def change
    rename_table :boulders, :setter_climb_logs
  end
end
