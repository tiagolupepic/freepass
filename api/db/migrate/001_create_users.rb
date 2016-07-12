class CreateUsers < ActiveRecord::Base
  def change
    create_table :users, id: :uuid do |t|
      t.string :full_name

      t.timestamps null: false
    end

    # add_index :users, :email, unique: true
  end
end
