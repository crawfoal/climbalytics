class RemoveDeviseColumnsFromUsers < ActiveRecord::Migration
  def up
    change_table(:users) do |t|
      t.remove :current_sign_in_at, :current_sign_in_ip, :email, :encrypted_password, :last_sign_in_at, :last_sign_in_ip, :remember_created_at, :reset_password_sent_at, :reset_password_token, :sign_in_count
    end
  end

  def down
    change_table(:users) do |t|
      t.string   "email",                  default: "", null: false
      t.string   "encrypted_password",     default: "", null: false
      t.string   "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count",          default: 0,  null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string   "current_sign_in_ip"
      t.string   "last_sign_in_ip"
      t.datetime "created_at",                          null: false
      t.datetime "updated_at",                          null: false
    end
  end
end
