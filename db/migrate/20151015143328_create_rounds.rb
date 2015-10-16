class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.references :sport, null: false, index: true, foreign_key: true

      t.string :name, null: false

      t.timestamp :opened_at
      t.timestamp :closed_at

      t.timestamps null: false
    end

    add_index :rounds, :opened_at
    add_index :rounds, :closed_at

    change_table :contests do |t|
      t.references :round, null: false, index: true, foreign_key: true
    end
  end
end
