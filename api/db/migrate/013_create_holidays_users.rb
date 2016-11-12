class CreateHolidaysUsers < ActiveRecord::Migration
  def change
    create_table :holidays_users, id: false do |t|
      t.references :holiday, :user, type: :uuid

      t.timestamps null: false
    end
  end
end
