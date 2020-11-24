class AddAttachmentTestfileToTestcases < ActiveRecord::Migration[6.0]
  def self.up
    change_table :testcases do |t|
      t.attachment :testfile
    end
  end

  def self.down
    remove_attachment :testcases, :testfile
  end
end
