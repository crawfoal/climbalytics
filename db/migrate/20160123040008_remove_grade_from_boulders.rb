class RemoveGradeFromBoulders < ActiveRecord::Migration
  def change
    remove_column :boulders, :grade, :integer
  end
end
