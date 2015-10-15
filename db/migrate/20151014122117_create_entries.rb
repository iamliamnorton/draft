class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :user, null: false, index: true, foreign_key: true
      t.references :contest, null: false, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index(:entries, [:user_id, :contest_id], unique: true)
  end
end
