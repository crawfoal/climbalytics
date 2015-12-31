class CreateNames < ActiveRecord::Migration
  def change
    create_table :names do |t|
      t.string :first
      t.string :last
      t.references :user, index: true, foreign_key: true
    end
  end
end
