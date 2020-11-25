class Testcase < ApplicationRecord
  belongs_to :project
  has_attached_file :testfile
  validates_attachment_content_type :testfile, :content_type => 'text/plain'
  
end
