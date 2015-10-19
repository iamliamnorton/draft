class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.references :sport, null: false, index: true, foreign_key: true

      t.integer :source_id

      t.string :name,         null: false
      t.string :city,         null: false, default: ""
      t.string :abbreviation, null: false, default: ""

      t.timestamps null: false
    end

    add_index :teams, :source_id
  end
end
