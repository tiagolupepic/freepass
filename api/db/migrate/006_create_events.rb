class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events, id: :uuid do |t|
      t.string :name
      t.references :user, :card, type: :uuid
      t.text :description

      t.timestamps null: false
    end
  end
end
