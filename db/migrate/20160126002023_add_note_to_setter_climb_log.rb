class AddNoteToSetterClimbLog < ActiveRecord::Migration
  def change
    add_column :setter_climb_logs, :note, :text
  end
end
