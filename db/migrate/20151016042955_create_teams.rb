class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.references :sport, index: true, foreign_key: true

      t.string :name, null: false

      t.timestamps null: false
    end

    add_index(:teams, [:sport_id, :name], unique: true)
  end
end
