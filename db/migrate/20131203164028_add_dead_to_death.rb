class AddDeadToDeath < ActiveRecord::Migration
  def change
    add_column :deaths, :dead, :boolean
  end
end
