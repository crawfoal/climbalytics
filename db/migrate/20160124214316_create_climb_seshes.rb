class CreateClimbSeshes < ActiveRecord::Migration
  def change
    create_table :climb_seshes do |t|
      t.integer :high_hold
      t.text :note
      t.references :athlete_climb_log, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
