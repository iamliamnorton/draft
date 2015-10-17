class CreateDraftPicks < ActiveRecord::Migration
  def change
    create_table :draft_picks do |t|
      t.references :roster, null: false, index: true, foreign_key: true
      t.references :player, null: false, index: true, foreign_key: true

      t.integer :cost, null: false

      t.timestamps null: false
    end

    add_index(:draft_picks, [:roster_id, :player_id], unique: true)
  end
end
