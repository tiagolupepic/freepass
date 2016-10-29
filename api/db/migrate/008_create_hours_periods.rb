class CreateHoursPeriods < ActiveRecord::Migration
  def change
    create_table :hours_periods, id: false do |t|
      t.references :hour, :period, type: :uuid

      t.timestamps null: false
    end
  end
end
