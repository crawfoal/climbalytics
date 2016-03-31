class RemoveGradeFromBoulderLogs < ActiveRecord::Migration
  def change
    remove_column :boulder_logs, :grade, :integer
  end
end
