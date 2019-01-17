class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :email
      t.string :password_digest
      t.index ["email"], name: "index_users_on_email", unique: true
      t.index ["username"], name: "index_users_on_username", unique: true

      t.timestamps
    end
  end
end
