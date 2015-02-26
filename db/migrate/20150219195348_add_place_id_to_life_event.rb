class AddPlaceIdToLifeEvent < ActiveRecord::Migration
  def change
    add_column :life_events, :place_id, :integer
  end
end
