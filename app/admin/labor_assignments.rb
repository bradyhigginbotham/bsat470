ActiveAdmin.register LaborAssignment do
  menu false
  controller.authorize_resource

  collection_action :mobile_get do
    if @labor = LaborAssignment.where("assignment_id = ?", params[:id])
			render :json => @labor
		else
			render :text => "record_not_found"
		end
  end

  collection_action :mobile_set do
    params[:labor].each do |key, labor|
      @labor = Labor.find(labor[:id])
      @labor.update_attributes(:hrs_used => labor[:hrs_used])

      if labor[:task][:completed] == true
        @task = Task.find(labor[:task][:id])
        @task.update_attributes(:status => "Completed", :date_completed => Date.today)
      end
    end
  end

end
