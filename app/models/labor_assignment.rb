class LaborAssignment < ActiveRecord::Base
  belongs_to :task
  belongs_to :employee
  belongs_to :assignment
end
