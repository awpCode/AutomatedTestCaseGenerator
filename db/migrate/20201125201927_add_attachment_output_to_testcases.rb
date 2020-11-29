class AddAttachmentOutputToTestcases < ActiveRecord::Migration[6.0]
  def self.up
    change_table :testcases do |t|
      t.attachment :output
    end
  end

  def self.down
    remove_attachment :testcases, :output
  end
end
