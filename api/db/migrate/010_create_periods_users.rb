class CreatePeriodsUsers < ActiveRecord::Migration
  def change
    create_table :periods_users, id: false do |t|
      t.references :period, :user, type: :uuid

      t.timestamps null: false
    end
  end
end
