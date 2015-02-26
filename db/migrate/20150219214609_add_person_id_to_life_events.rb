class AddPersonIdToLifeEvents < ActiveRecord::Migration
  def change
    add_column :life_events, :person_id, :integer
  end
end
