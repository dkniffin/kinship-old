class ChangePlacesToPolymorphic < ActiveRecord::Migration
  def change
    add_column :places, :locatable_id, :integer
    add_column :places, :locatable_type, :string
    
    remove_column :births, :place_id
    remove_column :deaths, :place_id
  end
end
