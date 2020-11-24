class RemoveDirtFromTestcases < ActiveRecord::Migration[6.0]
  def change
    remove_column :testcases, :input
    remove_column :testcases, :testcaseName
  end
end
