class CreateForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key :holidays_users, :holidays
    add_foreign_key :holidays_users, :users
  end
end
