class CreateRosters < ActiveRecord::Migration
  def change
    create_table :rosters do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :contest, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end

    add_index(:rosters, [:user_id, :contest_id], unique: true)
  end
end
