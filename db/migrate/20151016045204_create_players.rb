class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.references :team, index: true, foreign_key: true

      t.integer :source_id

      t.string :name,     null: false
      t.string :position, null: false, default: ""
      t.integer :salary,  null: false, default: 0

      t.timestamps null: false
    end

    add_index :players, :position
    add_index :players, :source_id
  end
end
