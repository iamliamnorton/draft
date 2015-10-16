class CreateRosterSpots < ActiveRecord::Migration
  def change
    create_table :roster_spots do |t|
      t.references :roster, null: false, index: true, foreign_key: true
      t.references :player, null: false, index: true, foreign_key: true

      t.integer :cost, null: false

      t.timestamps null: false
    end
  end
end
