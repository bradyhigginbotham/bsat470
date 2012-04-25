ActiveAdmin.register MaterialAssignment do
  menu false
  controller.authorize_resource

  collection_action :mobile_get do
    if @materials = MaterialAssignment.where("assignment_id = ?", params[:id]).order("task_id")
      @materials.each do |material|
        task = Task.find(material[:task_id])
        material[:task_name] = task.title
        mat = Material.find(material[:material_id])
        material[:mat_name] = mat.name
      end
			render :json => @materials
		else
			render :text => "record_not_found"
		end
  end

  collection_action :mobile_set do
    params[:materials].each do |key, material|
      @material = MaterialAssignment.find(material[:id])
      @material.update_attributes(:qty_used => material[:qty_used])
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
