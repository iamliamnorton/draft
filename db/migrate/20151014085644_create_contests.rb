class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.references :user, null: false, index: true, foreign_key: true

      t.integer :entry,             null: false
      t.integer :cap,               null: false,    default: 50_000
      t.integer :min_entries,       null: false,    default: 1
      t.integer :max_entries,       null: false

      t.timestamp :closed_at
      t.timestamp :started_at
      t.timestamp :won_at

      t.timestamps null: false
    end

    add_index :contests, :closed_at
    add_index :contests, :started_at
    add_index :contests, :won_at
  end
end
