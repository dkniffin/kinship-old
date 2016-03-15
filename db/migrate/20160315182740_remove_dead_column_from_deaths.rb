class RemoveDeadColumnFromDeaths < ActiveRecord::Migration
  def change
    remove_column :deaths, :dead
  end
end
