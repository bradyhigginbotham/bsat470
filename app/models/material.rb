class Material < ActiveRecord::Base
  has_many :material_assignments

  attr_accessible :name, :unit_cost, :quantity
  validates_presence_of :name, :unit_cost, :quantity
end
