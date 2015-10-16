class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :home_team, null: false, index: true
      t.references :away_team, null: false, index: true

      t.timestamp :started_at

      t.timestamps null: false
    end

    add_index :games, :started_at

    add_foreign_key :games, :teams, column: :home_team_id
    add_foreign_key :games, :teams, column: :away_team_id
  end
end
