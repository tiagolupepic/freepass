class AddForeignKey < ActiveRecord::Migration
  def change
    add_foreign_key :cards, :users
    add_foreign_key :events, :users
    add_foreign_key :hours_periods, :periods
    add_foreign_key :hours_periods, :hours
    add_foreign_key :periods_users, :periods
    add_foreign_key :periods_users, :users
  end
end
