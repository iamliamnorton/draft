class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.references :player, null: false, index: true, foreign_key: true
      t.references :game, null: false, index: true, foreign_key: true

      # multiples of tens for scoring, no decimals
      t.integer :points, null: false, default: 0

      t.timestamp :completed_at

      t.timestamps null: false
    end
  end
end
