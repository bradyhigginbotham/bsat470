class Assignment < ActiveRecord::Base
  before_create :default_values

  belongs_to :work_order
  belongs_to :employee
  belongs_to :vehicle

  has_many :labor_assignments, :dependent => :destroy
	accepts_nested_attributes_for :labor_assignments, :allow_destroy => true

  has_many :material_assignments, :dependent => :destroy
	accepts_nested_attributes_for :material_assignments, :allow_destroy => true

  attr_accessible :number, :start_date, :end_date, :created_by, :work_order_id, :employee_id, :vehicle_id,
                  :material_assignments_attributes, :labor_assignments_attributes
  validates_presence_of :number, :start_date, :created_by, :work_order_id, :employee_id

  def next_id
    if last_assignment = Assignment.last
      id = last_assignment.number
      id.slice!(0)
      count = id.count("0")
      id = (id.to_i + 1).to_s
      for i in 0...count do
        id = "0" + id
      end
      next_id = "A" + id
    else
      next_id = "A001" # first assignment
    end
  end

  def default_values
    authorizer = Employee.find_by_name(self[:created_by])
    self[:created_by] = authorizer.id
  end
end
