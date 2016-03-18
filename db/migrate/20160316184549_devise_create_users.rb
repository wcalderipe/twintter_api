class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :username, null: false, default: ''
      t.string :first_name, null: false, default: ''
      t.string :last_name, null: false, default: ''
      t.string :email, null: false, default: ''
      t.string :encrypted_password, null: false, default: ''
      t.string  :reset_password_token
      t.datetime :reset_password_sent_at
      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
