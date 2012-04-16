class MaterialAssignment < ActiveRecord::Base
  before_create :change_task_status
  before_update :set_quantities

  belongs_to :task
  belongs_to :material
  belongs_to :assignment

  def change_task_status
    if self[:task_id]
      task = Task.find(self[:task_id])
      task.update_attributes(:status => "In Progress")
    end
  end

  def set_quantities
    if self[:qty_used]
      material = Material.find(self[:material_id])
      mat_assignment = MaterialAssignment.find(self[:id])
      if mat_assignment.qty_used
        difference = self[:qty_used] - mat_assignment.qty_used
        material.update_attributes(:quantity => material.quantity - difference)
      else
        material.update_attributes(:quantity => material.quantity - self[:qty_used])
      end
    end
  end

end
