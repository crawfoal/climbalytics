class AddCurrentRoleToUser < ActiveRecord::Migration
  def change
    add_column :users, :current_role, :string
  end
end
