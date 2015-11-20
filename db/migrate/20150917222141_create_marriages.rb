class CreateMarriages < ActiveRecord::Migration
  def change
    create_table :marriages do |t|
      t.integer :person_1_id
      t.integer :person_2_id

      t.timestamps null: false
    end
  end
end
