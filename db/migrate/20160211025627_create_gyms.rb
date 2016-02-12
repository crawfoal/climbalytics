class CreateGyms < ActiveRecord::Migration
  def change
    create_table :gyms do |t|
      t.string :name, null: false
      t.string :topo, null: false

      t.timestamps null: false
    end
  end
end
