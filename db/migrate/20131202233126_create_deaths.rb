class CreateDeaths < ActiveRecord::Migration
  def change
    create_table :deaths do |t|
      t.integer :person_id
      t.date :date
      t.integer :place_id
      t.string :cause

      t.timestamps
    end
  end
end
