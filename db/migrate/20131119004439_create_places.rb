class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :country
      t.string :state
      t.string :county
      t.string :postal_code
      t.string :city
      t.string :street_address

      t.timestamps
    end
  end
end
