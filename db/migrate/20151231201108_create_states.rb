class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :postal_abbreviation, limit: 2
      t.string :full_name, limit: 50

      t.timestamps null: false
    end
  end
end
