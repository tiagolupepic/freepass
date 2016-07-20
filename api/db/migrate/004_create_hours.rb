class CreateHours < ActiveRecord::Migration
  def change
    enable_extension "hstore"
    create_table :hours, id: :uuid do |t|
      t.string :name
      t.datetime :start_at, :end_at
      t.hstore :days

      t.timestamps null: false
    end
  end
end
