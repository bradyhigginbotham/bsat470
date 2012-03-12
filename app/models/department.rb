class Department < ActiveRecord::Base
  has_many :employees
  accepts_nested_attributes_for :employees

  attr_accessible :title
  validates_presence_of :title
end
