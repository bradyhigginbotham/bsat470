class Invoice < ActiveRecord::Base
  belongs_to :client

  has_many :work_orders
  accepts_nested_attributes_for :work_orders

  attr_accessible       :number, :start_date, :end_date, :client_id, :paid
  validates_presence_of :number, :start_date, :end_date, :client_id

  scope :paid, where("invoices.paid = true")
  scope :unpaid, where("invoices.paid = false")

  def self.next_id
    if last_inv = Invoice.last
      id = last_inv.number
      id.slice!(0)
      count = id.count("0")
      id = (id.to_i + 1).to_s
      for i in 0...count do
        id = "0" + id
      end
      next_id = "I" + id
    else
      next_id = "I001" # first invoice
    end
  end

end
