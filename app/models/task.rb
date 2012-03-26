class Task < ActiveRecord::Base
  before_create :defaults

  belongs_to :location

  has_many :labor_assignments
  accepts_nested_attributes_for :labor_assignments
 
  has_many :material_assignments
  accepts_nested_attributes_for :material_assignments

  attr_accessible :title, :status, :sqft, :price_per_sqft, :est_hours, :date_completed, :location_id
  validates_presence_of :title, :sqft, :price_per_sqft, :location_id

  def defaults
    self[:status] = "Pending"
  end

end
