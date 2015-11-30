class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.integer :referenceable_id, index: true, foreign_key: true
      t.string :referenceable_type
      t.references :source, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
