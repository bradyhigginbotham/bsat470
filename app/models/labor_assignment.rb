class LaborAssignment < ActiveRecord::Base
  before_create :change_task_status

  belongs_to :task
  belongs_to :employee
  belongs_to :assignment

  def change_task_status
    if self[:task_id]
      task = Task.find(self[:task_id])
      task.update_attributes(:status => "In Progress")
    end
  end
end
