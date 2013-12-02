class AddBirthIdToPlace < ActiveRecord::Migration
  def change
    add_column :places, :birth_id, :integer
  end
end
