class AddDateToMarriage < ActiveRecord::Migration
  def change
    add_column :marriages, :date, :date
  end
end
