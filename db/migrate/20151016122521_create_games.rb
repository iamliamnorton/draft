class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :season, null: false, index: true, foreign_key: true
      t.references :round, null: false, index: true, foreign_key: true

      t.references :home_team, index: true, null: false
      t.references :away_team, index: true, null: false

      t.integer :source_id

      t.timestamp :started_at
      t.timestamp :completed_at

      t.timestamps null: false
    end

    add_index :games, :source_id
    add_index :games, :started_at
    add_index :games, :completed_at

    add_foreign_key :games, :teams, column: :home_team_id
    add_foreign_key :games, :teams, column: :away_team_id
  end
end
