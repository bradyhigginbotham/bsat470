ActiveAdmin.register MaterialAssignment do
  menu false
  controller.authorize_resource

  collection_action :mobile_get do
    if @materials = MaterialAssignment.where("assignment_id = ?", params[:id])
			render :json => @materials
		else
			render :text => "record_not_found"
		end
  end

  collection_action :mobile_set do
    params[:materials].each do |key, material|
      @material = Material.find(material[:id])
      @material.update_attributes(:qty_used => material[:qty_used])

      if material[:task][:completed] == true
        @task = Task.find(material[:task][:id])
        @task.update_attributes(:status => "Completed", :date_completed => Date.today)
      end
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :assignment_id, :as => :hidden, :input_html => {:value => f.object.assignment_id}
      f.input :task
  		f.input :material
      f.input :qty_sent
      f.input :qty_used
    end

    f.buttons
  end

end
