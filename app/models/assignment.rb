class Assignment < ActiveRecord::Base
  has_many :labor_assignments, :dependent => :destroy
	accepts_nested_attributes_for :labor_assignments, :allow_destroy => true

  has_many :material_assignments, :dependent => :destroy
	accepts_nested_attributes_for :material_assignments, :allow_destroy => true

  attr_accessible :number, :start_date, :end_date, :supervisor
  validates_presence_of :number, :start_date, :supervisor, :work_order_id
end
