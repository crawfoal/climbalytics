class CreateBoulders < ActiveRecord::Migration
  def change
    create_table :boulders do |t|
      t.string :name
      t.integer :grade
      t.string :picture

      t.timestamps null: false
    end
  end
end
