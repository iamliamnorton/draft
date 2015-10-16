class CreateRosters < ActiveRecord::Migration
  def change
    create_table :rosters do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :contest, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
