class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.integer :entry,                 null: false
      t.integer :cap,                   null: false

      t.timestamp :cancelled_at
      t.timestamp :closed_at
      t.timestamp :won_at

      t.timestamps null: false
    end

    add_index :contests, :cancelled_at
    add_index :contests, :closed_at
    add_index :contests, :won_at
  end
end
