class CreateTestcases < ActiveRecord::Migration[6.0]
  def change
    create_table :testcases do |t|
      t.integer :project_id
      t.text :input
      t.timestamps
      t.string :testcaseName
    end
  end
end
