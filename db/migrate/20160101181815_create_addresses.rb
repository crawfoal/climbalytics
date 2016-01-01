class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :line1
      t.string :line2
      t.string :city
      t.references :state, index: true, foreign_key: true
      t.string :zip
      t.integer :addressable_id
      t.string :addressable_type

      t.timestamps null: false
    end
    add_index :addresses, [:addressable_id, :addressable_type], unique: true
  end
end
