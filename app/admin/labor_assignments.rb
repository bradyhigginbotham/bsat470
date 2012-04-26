ActiveAdmin.register LaborAssignment do
  menu false
  controller.authorize_resource

  collection_action :mobile_get do
    if @labor = LaborAssignment.where("assignment_id = ?", params[:id])
      @labor.each do |labor|
        task = Task.find(labor[:task_id])
        labor[:task_name] = task.title
        if task.status == "Completed"
          labor[:completed] = true
        end
        emp = Employee.find(labor[:employee_id])
        labor[:emp_name] = emp.name
      end
			render :json => @labor
		else
			render :text => "record_not_found"
		end
  end

  collection_action :mobile_set do
    params[:labor].each do |key, labor|
      @labor = LaborAssignment.find(labor[:id])
      @labor.update_attributes(:hrs_used => labor[:hrs_used])
    end
  end

end
