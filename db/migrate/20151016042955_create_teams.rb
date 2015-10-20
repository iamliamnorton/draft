class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.references :season, null: false, index: true, foreign_key: true

      t.string :name, null: false
      t.string :city
      t.string :abbreviation

      t.integer :source_id

      t.timestamps null: false
    end

    add_index :teams, :source_id
  end
end
