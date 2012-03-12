class WorkOrder < ActiveRecord::Base
  belongs_to :proposal

  has_many :employees
  accepts_nested_attributes_for :employees

  has_many :assignments
  accepts_nested_attributes_for :assignments

  attr_accessible       :notes, :date_required, :employee_id, :proposal_id
  validates_presence_of :date_required, :employee_id, :proposal_id
end
