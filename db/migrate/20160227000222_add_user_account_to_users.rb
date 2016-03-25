class AddUserAccountToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :user_account, index: true, foreign_key: true
  end
end
