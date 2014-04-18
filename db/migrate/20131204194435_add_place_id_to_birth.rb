class AddPlaceIdToBirth < ActiveRecord::Migration
  def change
    add_column :births, :place_id, :integer
  end
end
