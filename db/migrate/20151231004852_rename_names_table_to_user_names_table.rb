class RenameNamesTableToUserNamesTable < ActiveRecord::Migration
  def change
    rename_table :names, :user_names
  end
end
