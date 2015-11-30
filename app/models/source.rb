class Source < ActiveRecord::Base
  validates :title, presence: true
  has_many :references
  has_many :referenceables, through: :references
end
