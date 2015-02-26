class CreateLifeEvents < ActiveRecord::Migration
  def change
    create_table :life_events do |t|
      t.string :type
      t.date :date
      t.date :end_date

      t.timestamps
    end

  	drop_table :deaths
  	drop_table :births
  end
end
