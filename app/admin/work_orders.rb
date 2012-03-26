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
          :location_id => task[:location_id]
        )
      end

      super
    end

    def update
      params[:tasks].each do |key, task|
        @task = Task.find(task[:id])
        @task.update_attributes(
          :title => task[:title],
          :status => task[:status],
          :sqft => task[:sqft],
          :price_per_sqft => task[:price_per_sqft],
          :est_hours => task[:est_hours],
          :date_completed => task[:date_completed],
          :location_id => task[:location_id]
        )
      end

      super
    end
  end

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
    column :date_required
    column :proposal
    column :location
    column "Created On", :created_at
    column "Updated On", :updated_at
  end

	show :title => :number do
		attributes_table do
			row ("Work Order ID") {resource.number}
      row ("Manager") {resource.employee}
			row :level
			row :proposal
			row :location
			row ("Created On") {resource.created_at}
			row ("Updated On") {resource.updated_at}
      row :notes
		end

		panel "Tasks" do
    	table_for work_order.location.tasks do
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
  end



  form :partial => "form"

  filter :number, :label => "ID"
  filter :employee, :label => "Manager"
  filter :level, :as => :select, :collection => ["Primary", "Secondary"]
  filter :proposal
  filter :location
  filter :date_required
  filter :created_at, :label => "Created On"
  filter :updated_at, :label => "Updated On"
end
