class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :testcaseCount
      t.integer :user_id
      t.text :script
      t.timestamps
    end
  end
end
