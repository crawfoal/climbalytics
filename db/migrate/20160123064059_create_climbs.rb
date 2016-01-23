class CreateClimbs < ActiveRecord::Migration
  def change
    create_table :climbs do |t|
      t.integer :grade
      t.string :name
      t.integer :moves_count
      t.string :type
      t.references :loggable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
