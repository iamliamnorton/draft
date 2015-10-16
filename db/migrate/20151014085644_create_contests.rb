class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.references :user, null: false, index: true, foreign_key: true

      t.integer :entry,             null: false
      t.integer :cap,               null: false,    default: 50_000
      t.integer :min_entries,       null: false,    default: 1
      t.integer :max_entries,       null: false

      t.timestamp :settled_at

      t.timestamps null: false
    end

    add_index :contests, :settled_at
  end
end
