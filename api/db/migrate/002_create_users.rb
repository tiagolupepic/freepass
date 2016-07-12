class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: :uuid do |t|
      t.string :full_name, :phone, :address, :email
      t.string :password, :cpf
      t.string :role, :state, :reset_password_token
      t.datetime :reset_password_sent_at

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :cpf, unique: true
  end
end
