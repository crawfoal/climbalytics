class CreateBoulderLogs < ActiveRecord::Migration
  def change
    create_table :boulder_logs do |t|
      t.integer :grade
      t.integer :quality_rating
      t.text :note
      t.boolean :project
      t.references :athlete_story, index: true, foreign_key: true
      t.references :boulder, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
