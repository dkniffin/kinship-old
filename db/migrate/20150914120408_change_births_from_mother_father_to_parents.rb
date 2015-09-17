class ChangeBirthsFromMotherFatherToParents < ActiveRecord::Migration
  def change
    rename_column :births, :father_id, :parent_1_id
    rename_column :births, :mother_id, :parent_2_id
  end
end
