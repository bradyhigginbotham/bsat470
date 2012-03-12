class Vehicle < ActiveRecord::Base
  has_many :assignments

  attr_accessible       :make, :model, :year, :checked_out
  validates_presence_of :make, :model, :year
end
