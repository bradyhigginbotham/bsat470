ActiveAdmin.register WorkOrder do
  menu :label => "Work Orders", :priority => 5, :if => proc{ can?(:manage, WorkOrder) }     
  controller.authorize_resource

  controller do
    def create
      params[:tasks].each do |key, task|
        @task = Task.find(task[:id])
        @task.update_attributes(
          :title => task[:title],
          :status => task[:status],
          :sqft => task[:sqft],
          :price_per_sqft => task[:price_per_sqft],
          :est_hours => task[:est_hours],
          :date_completed => task[:date_completed],
          :location_id => task[:location_id],
          :work_order_id => WorkOrder.last.id + 1
        )
      end

      super
    end

    def update
      params[:tasks].each do |key, task|
        @task = Task.find(task[:id])
        if !@task.date_completed && task[:status] == "Completed"
          @task.update_attributes(
            :title => task[:title],
            :status => task[:status],
            :sqft => task[:sqft],
            :price_per_sqft => task[:price_per_sqft],
            :est_hours => task[:est_hours],
            :date_completed => Date.today,
            :location_id => task[:location_id]
          )
        else
          @task.update_attributes(
            :title => task[:title],
            :status => task[:status],
            :sqft => task[:sqft],
            :price_per_sqft => task[:price_per_sqft],
            :est_hours => task[:est_hours],
            :location_id => task[:location_id]
          )
        end
      end

      super
    end
  end

  scope :all, :default => true
  scope :completed

  action_item :only => :show do
    link_to "Print PDF", pdf_admin_work_order_path(work_order)
  end

  member_action :pdf do
    @work_order = WorkOrder.find(resource)
    respond_to do |format|
      format.html do
          render :pdf         => "#{@work_order.number}_#{@work_order.location.name}",
                 :wkhtmltopdf => '/usr/bin/wkhtmltopdf', # path to binary
                 :header      => {:center => "#{@work_order.level} Work Order"},
                 :margin      => {:bottom         => 10,
                                  :left           => 10,
                                  :right          => 10}
      end
    end
  end

  index do
    selectable_column
    column "ID", :sortable => :number do |wo|
      link_to wo.number, admin_work_order_path(wo)
    end
    column :level
    column "Manager", :employee
    column "Current State", :sortable => :invoice do |wo|
      if wo.invoice
        status_tag("Complete")
      else
        status_tag("In Progress")
      end
    end
    column :location
    column "Proposal", :sortable => :proposal do |wo|
      link_to wo.proposal.number, admin_proposal_path(wo.proposal)
    end
    column :date_required
    column "Created On", :created_at
   # column "Updated On", :updated_at
  end

	show :title => :number do
		attributes_table do
			row ("Work Order ID") {resource.number}
      row ("Manager") {resource.employee}
			row :level
      row ("Proposal") do |resource|
        raw link_to(resource.proposal.number, admin_proposal_path(resource.proposal))
      end
			row :location
			row ("Created On") {resource.created_at}
			row ("Updated On") {resource.updated_at}
      row :notes
      row ("Invoice") do |resource|
        if resource.invoice
          raw link_to(resource.invoice.number, admin_invoice_path(resource.invoice))
        end
      end
		end

		panel "Assignments" do
    	table_for work_order.assignments do
				column("") do |resource| 
          span link_to(image_tag('application_edit.png', :title => 'Edit'), edit_admin_assignment_path(resource))	if controller.current_ability.can? :manage, Assignment
        end
			  column ("ID") do |resource|
          link_to(resource.number, admin_assignment_path(resource))	if controller.current_ability.can? :show, Assignment
        end
			  column ("Vehicle") do |a|
          link_to("#{a.vehicle.make} #{a.vehicle.model} (#{a.vehicle.year})", admin_vehicle_path(a.vehicle))
        end
			  column ("Supervisor") do |resource|
          link_to(resource.employee.name, admin_employee_path(resource.employee))	if controller.current_ability.can? :show, Employee
        end
			  column ("Authorized By") do |resource|
          auther = Employee.find(resource.created_by)
          link_to(auther.name, admin_employee_path(auther))	if controller.current_ability.can? :show, Employee
        end
        column :start_date
        column ("Finish Date") {|a| a.end_date}
    	end

      div do
	      link_to "Add Assignment", new_admin_assignment_path(), :class => "panel_button"
	      #link_to "Add Assignment", new_admin_assignment_path().to_s + "?&assignment[work_order_id]=#{work_order.id}", :class => "panel_button"
    	end
  	end

		panel "Tasks" do
    	table_for work_order.tasks do
        column :title
        column("Status") {|task| status_tag(task.status) }
        column :sqft
        column("Price/Sq. Ft.") {|task| task.price_per_sqft }
        column :est_hours
        column :date_completed
			  column "Created On", :created_at
			  column "Updated On", :updated_at
    	end
  	end

    active_admin_comments
  end



  form :partial => "form"

  filter :number, :label => "Work Order ID"
  filter :employee, :label => "Manager"
  filter :level, :as => :select, :collection => ["Primary", "Secondary"]
  filter :proposal
  filter :location
  filter :date_required
  filter :created_at, :label => "Created On"
  filter :updated_at, :label => "Updated On"
end
