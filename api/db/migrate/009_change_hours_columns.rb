class ChangeHoursColumns < ActiveRecord::Migration
  def change
    change_column :hours, :start_at, :time
    change_column :hours, :end_at, :time
  end
end
