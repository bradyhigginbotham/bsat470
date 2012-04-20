class Task < ActiveRecord::Base
  before_create :defaults
  after_update :invoice

  belongs_to :location
  belongs_to :work_order

  has_many :labor_assignments
  accepts_nested_attributes_for :labor_assignments
 
  has_many :material_assignments
  accepts_nested_attributes_for :material_assignments

  attr_accessible :title, :status, :sqft, :price_per_sqft, :est_hours, :date_completed, :location_id, :work_order_id
  validates_presence_of :title, :sqft, :price_per_sqft, :location_id

  def defaults
    self[:status] = "Pending"
  end

  def invoice
    completed = 0
    tasks_array = []

    if self[:status] == "Completed" && self[:work_order_id]
      locations = Location.where("proposal_id = ?", self.work_order.proposal_id)

      locations.each do |location|
        tasks = Task.where("location_id = ?", location.id)
        tasks.each do |task|
          tasks_array.push(task)
          if task.status == "Completed"
            completed += 1
          end
        end
      end

      if tasks_array.length == completed # all tasks are completed
        invoice = Invoice.create!(
          :number => Invoice.next_id,
          :start_date => self.work_order.proposal.updated_at,
          :end_date => self[:updated_at],
          :client_id => self.work_order.proposal.client.id,
          :paid => false
        )

        tasks_array.each do |task|
          wo = WorkOrder.find(task.work_order_id)
          wo.update_attributes(:invoice_id => invoice.id)
        end
      end      
    end
  end

end
