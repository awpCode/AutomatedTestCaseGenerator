class Testcase < ApplicationRecord
  belongs_to :project
  has_attached_file :testfile
  validates_attachment_content_type :testfile, :content_type => ['text/plain', 'application/octet-stream']

  has_attached_file :output
  validates_attachment_content_type :output, :content_type => ['text/plain', 'application/octet-stream']
end
