class AddSpouseToPerson < ActiveRecord::Migration
  def change
    add_column :people, :spouse_id, :integer
  end
end
