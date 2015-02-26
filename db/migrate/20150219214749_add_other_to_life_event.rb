class AddOtherToLifeEvent < ActiveRecord::Migration
  def change
    add_column :life_events, :other_attributes, :hstore
  end
end
