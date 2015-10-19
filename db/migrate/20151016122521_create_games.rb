class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :sport, null: false, index: true, foreign_key: true
      t.references :round, null: false, index: true, foreign_key: true
      t.references :team, null: false, index: true, foreign_key: true

      t.integer :source_id

      t.timestamp :started_at

      t.timestamps null: false
    end

    add_index :games, :started_at

    add_index(:games, [:sport_id, :team_id, :round_id], unique: true)
  end
end
