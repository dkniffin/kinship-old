class RemovePortraitLink < ActiveRecord::Migration
  def change
     remove_column :people, :portrait_link
  end
end
