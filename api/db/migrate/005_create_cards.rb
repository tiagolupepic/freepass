class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards, id: :uuid do |t|
      t.string :number
      t.references :user, type: :uuid
      t.boolean :is_admin, default: false

      t.timestamps null: false
    end
  end
end
