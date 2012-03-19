class Proposal < ActiveRecord::Base
  belongs_to :client
  belongs_to :employee

	has_many :locations
	accepts_nested_attributes_for :locations, :allow_destroy => true

  has_many :tasks, :through => :locations
	accepts_nested_attributes_for :tasks

  has_many :work_orders, :dependent => :destroy
	accepts_nested_attributes_for :work_orders, :allow_destroy => true

  attr_accessible :number, :status, :est_method, :customer_type, :decision_date, :client_id, :employee_id, 
                  :locations_attributes, :tasks_attributes
  validates_presence_of :number, :status, :est_method, :customer_type, :employee_id

  scope :pending, where("proposals.status = 'Pending'")
  scope :accepted, where("proposals.status = 'Accepted'")
  scope :declined, where("proposals.status = 'Declined'")


  def next_id
    if last_prop = Proposal.last
      id = last_prop.number
      id.slice!(0)
      count = id.count("0")
      id = (id.to_i + 1).to_s
      for i in 0...count do
        id = "0" + id
      end
      next_id = "P" + id
    else
      next_id = "P001" # first proposal
    end
  end

end
