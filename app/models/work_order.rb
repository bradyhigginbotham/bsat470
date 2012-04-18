class WorkOrder < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :location
  belongs_to :employee
  belongs_to :invoice

  has_many :tasks
  accepts_nested_attributes_for :tasks

  has_many :assignments, :dependent => :destroy
  accepts_nested_attributes_for :assignments

  attr_accessible       :number, :notes, :date_required, :level, :employee_id, :proposal_id, :location_id, :invoice_id
  validates_presence_of :number, :date_required, :level, :employee_id, :proposal_id, :location_id

  scope :completed, where("work_orders.invoice_id IS NOT NULL")

  def next_id
    if last_wo = WorkOrder.last
      id = last_wo.number
      id.slice!(0)
      count = id.count("0")
      id = (id.to_i + 1).to_s
      for i in 0...count do
        id = "0" + id
      end
      next_id = "W" + id
    else
      next_id = "W001" # first work order
    end
  end

end
