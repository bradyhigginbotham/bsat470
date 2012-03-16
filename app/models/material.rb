class Material < ActiveRecord::Base
  has_many :material_assignments

  scope :low_quantity, where("materials.quantity < 10")

  attr_accessible :name, :unit_cost, :quantity
  validates_presence_of :name, :unit_cost, :quantity
end
