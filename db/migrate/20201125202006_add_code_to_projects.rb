class AddCodeToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :code, :text, :limit => 700000
  end
end
