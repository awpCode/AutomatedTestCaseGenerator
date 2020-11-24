class RemoveScriptFromProjects < ActiveRecord::Migration[6.0]
  remove_column :projects, :script
  def change
  end
end
