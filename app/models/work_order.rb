class WorkOrder < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :employee

  has_many :assignments
  accepts_nested_attributes_for :assignments

  attr_accessible       :number, :notes, :date_required, :employee_id, :proposal_id
  validates_presence_of :date_required, :employee_id, :proposal_id
end
