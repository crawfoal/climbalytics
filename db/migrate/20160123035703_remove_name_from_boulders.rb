class RemoveNameFromBoulders < ActiveRecord::Migration
  def change
    remove_column :boulders, :name, :string
  end
end
