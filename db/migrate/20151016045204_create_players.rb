class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.references :team, null: false, index: true, foreign_key: true

      t.string :name, null: false
      t.string :position, null: false
      t.integer :salary, null: false

      t.timestamps null: false
    end

    add_index :players, :position
  end
end
