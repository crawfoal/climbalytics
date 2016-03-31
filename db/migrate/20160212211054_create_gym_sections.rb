class CreateGymSections < ActiveRecord::Migration
  def change
    create_table :gym_sections do |t|
      t.string :name, null: false
      t.references :gym, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
