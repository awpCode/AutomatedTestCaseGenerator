class Project < ApplicationRecord
  belongs_to :user
  has_many :testcases, dependent: :destroy
  validates :name ,presence: true, length: {minimum: 6,maximum: 100}
  validates :testcaseCount, numericality: { only_integer: true ,greater_than: 0, less_than_or_equal_to: 10}
end
