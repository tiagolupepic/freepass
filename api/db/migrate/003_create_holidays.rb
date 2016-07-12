class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays, id: :uuid do |t|
      t.string :name
      t.date :happen_at

      t.timestamps null: false
    end
  end
end
