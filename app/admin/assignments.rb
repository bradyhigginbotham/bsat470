ActiveAdmin.register Assignment do
  menu :if => proc{ can?(:manage, Assignment) }     
  controller.authorize_resource

  controller do
    def new
      super do
        resource.material_assignments.build
        resource.labor_assignments.build
      end
    end

    def update
      emp = Employee.find_by_name(params[:assignment][:created_by])
      params[:assignment][:created_by] = emp.id

      super
    end
  end

  scope :all, :default => true
  scope :in_progress
  scope :completed

  action_item :only => :show do
    link_to "Print PDF", pdf_admin_assignment_path(assignment)
  end

  member_action :pdf do
    @assignment = Assignment.find(resource)
    @auther = Employee.find(@assignment.created_by)
    respond_to do |format|
      format.html do
          render :pdf         => "#{@assignment.number}_#{@assignment.work_order.location.name}",
                 :wkhtmltopdf => '/usr/bin/wkhtmltopdf', # path to binary
                 :header      => {:center => "Work Assignment"},
                 :margin      => {:bottom         => 10,
                                  :left           => 10,
                                  :right          => 10}
      end
    end
  end

  collection_action :mobile do
    if @assignments = Assignment.where("employee_id = ? AND end_date IS NULL", current_employee.id)
			render :json => @assignments
		else
			render :text => "record_not_found"
		end
  end

  index do
    selectable_column
    column "ID", :sortable => :number do |a|
      link_to a.number, admin_assignment_path(a)
    end
    column "Supervisor", :employee
    column "Current State", :sortable => :end_date do |a|
      if a.end_date
        status_tag("Completed")
      else
        status_tag("In Progress")
      end
    end
    column "Vehicle", :sortable => :vehicle do |a|
      link_to "#{a.vehicle.make} #{a.vehicle.model} (#{a.vehicle.year})", admin_vehicle_path(a.vehicle)
    end
    column "Work Order", :sortable => :work_order do |a|
      link_to "#{a.work_order.number}", admin_work_order_path(a.work_order)
    end
    column :start_date
    column :end_date
    column "Authorized By", :sortable => :created_by do |a|
      auther = Employee.find(a.created_by)
      raw link_to("#{auther.name}", admin_employee_path(auther))
    end
#    column "Created On", :created_at
#    column "Updated On", :updated_at
  end

	show :title => :number do
		attributes_table do
			row ("Assignment ID") {resource.number}
      row ("Work Order") do |resource|
        raw link_to("#{resource.work_order.number}", admin_work_order_path(resource.work_order))
      end
      row ("Supervisor") {resource.employee}
			row :start_date
			row :end_date
      row ("Vehicle") do |resource|
        if resource.vehicle
          raw link_to("#{resource.vehicle.make} #{resource.vehicle.model} (#{resource.vehicle.year})", admin_vehicle_path(resource.vehicle))
        else
          "N/A"
        end
      end
      row ("Authorized By") do |resource|
        auther = Employee.find(resource.created_by)
        raw link_to("#{auther.name}", admin_employee_path(auther))
      end
			row ("Authorized Date") {resource.created_at.strftime('%B %d, %Y')}
		end

		panel "Materials" do
    	table_for assignment.material_assignments do
			  column("") do |resource| 
          span link_to(image_tag('application_edit.png', :title => 'Edit'), edit_admin_material_assignment_path(resource))	if controller.current_ability.can? :edit, MaterialAssignment
        end
        column :task
        column :material
        column :qty_sent
        column :qty_used
			  column "Created On", :created_at
			  column "Updated On", :updated_at
    	end
  	end

		panel "Labor" do
    	table_for assignment.labor_assignments do
			  column("") do |resource| 
          span link_to(image_tag('application_edit.png', :title => 'Edit'), edit_admin_labor_assignment_path(resource))	if controller.current_ability.can? :edit, LaborAssignment
        end
        column :task
        column :employee
        column ("Est. Hours") {|l| l.est_hours}
        column ("Hrs Used") {|l| l.used_hours}
			  column "Created On", :created_at
			  column "Updated On", :updated_at
    	end
  	end

    active_admin_comments
  end

  form :partial => "form"

  filter :number, :label => "Assignment ID"
  #filter :employee, :label => "Supervisor", :as => :select, :collection => Employee.supervisors.collect{|emp| [emp.name, emp.id]}
  #filter :vehicle, :as => :select, :collection => Vehicle.all.collect{|v| ["#{v.make} #{v.model} (#{v.year})", v.id]}
  #filter :work_order, :as => :select, :collection => WorkOrder.all.collect{|wo| ["#{wo.number} - #{wo.location.name}", wo.id]}
  filter :start_date
  filter :end_date
  #filter :created_by, :label => "Authorized By", :as => :select, :collection => Employee.where("department_id != 2").collect{|emp| [emp.name, emp.id]}
  filter :created_at, :label => "Authorization Date"
end
