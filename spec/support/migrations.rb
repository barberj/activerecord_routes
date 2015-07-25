class Migrations < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :email, null: false
      t.integer :first_name
      t.integer :last_name

      t.timestamps null: false
    end
  end

  def down
    drop_table :users
  end
end
