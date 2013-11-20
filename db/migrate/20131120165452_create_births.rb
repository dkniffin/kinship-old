class CreateBirths < ActiveRecord::Migration
  def change
    create_table :births do |t|
      t.date :date

      t.belongs_to :child, :class_name => "Person", :foreign_key => "child"

      t.integer :father_id
      t.integer :mother_id

      t.timestamps
    end
  end
end
