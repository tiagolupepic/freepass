class ChangeEvents < ActiveRecord::Migration
  def change
    remove_column :events, :card_id
    add_column :events, :card_number, :string, default: nil
  end
end
