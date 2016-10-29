class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods, id: :uuid do |t|
      t.string :name
      t.datetime :start_at, :end_at

      t.timestamps null: false
    end
  end
end
