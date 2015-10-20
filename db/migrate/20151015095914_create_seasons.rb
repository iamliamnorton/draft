class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.string :name, null: false
      t.string :year, null: false
      t.integer :max_draft_picks, null: false, default: 10

      t.timestamps null: false
    end
  end
end
