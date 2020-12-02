class CreateTests < ActiveRecord::Migration[6.0]
  def change
    create_table :tests do |t|
      t.string :name
      t.integer :lowlimit
      t.integer :highlimit
      t.integer :rowsize
      t.integer :colsize
      t.integer :flag
      t.integer :project_id
    end
  end
end
