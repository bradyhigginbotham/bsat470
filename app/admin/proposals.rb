ActiveAdmin.register Proposal do
  #actions :all, :except => :edit, :if => resource.status == "Accepted"

  menu :priority => 4, :if => proc{ can?(:manage, Proposal) }     
  controller.authorize_resource


  controller do
    def new
      super do
        resource.locations.build
        resource.locations.first.tasks.build
      end
    end

    def create
      if params[:client_record] == 'new'
        @client = Client.create!(
          :number => params[:client][:number],
          :name => params[:client][:name],
          :email => params[:client][:email],
          :phone => params[:client][:phone],
          :billing_name => params[:client][:billing_name],
          :billing_address => params[:client][:billing_address],
          :city => params[:client][:city],
          :state => params[:client][:state],
          :zip => params[:client][:zip]
        )

      else # existing
        @client = Client.find(params[:client][:id])
        @client.update_attributes(
          :number => params[:client][:number],
          :name => params[:client][:name],
          :email => params[:client][:email],
          :phone => params[:client][:phone],
          :billing_name => params[:client][:billing_name],
          :billing_address => params[:client][:billing_address],
          :city => params[:client][:city],
          :state => params[:client][:state],
          :zip => params[:client][:zip]
        )
      end

      @proposal = Proposal.create!(
        :number => params[:proposal][:number],
        :status => params[:proposal][:status],
        :decision_date => params[:proposal][:decision_date],
        :est_method => params[:proposal][:est_method],
        :customer_type => params[:proposal][:customer_type],
        :client_id => @client.id,
        :employee_id => params[:proposal][:employee_id]
      )

      params[:proposal][:locations_attributes].each do |key, location|
        if params[:client_record] == 'new'
          @location = Location.create!(
            :name => location[:name],
            :address => location[:address],
            :city => location[:city],
            :state => location[:state],
            :zip => location[:zip],
            :client_id => @client.id,
            :proposal_id => @proposal.id
          )
        else
          @location = Location.create!(
            :name => location[:name],
            :address => location[:address],
            :city => location[:city],
            :state => location[:state],
            :zip => location[:zip],
            :client_id => location[:client_id],
            :proposal_id => @proposal.id
          )
        end

        location[:tasks_attributes].each do |key, task|
          @task = Task.create!(
            :title => task[:title],
            :status => task[:status],
            :sqft => task[:sqft],
            :price_per_sqft => task[:price_per_sqft],
            :est_hours => task[:est_hours],
            :location_id => @location.id
          )
        end
      end

      super
    end

    def update
      @client = Client.find(params[:client][:id])
      @client.update_attributes(
        :number => params[:client][:number],
        :name => params[:client][:name],
        :email => params[:client][:email],
        :phone => params[:client][:phone],
        :billing_name => params[:client][:billing_name],
        :billing_address => params[:client][:billing_address],
        :city => params[:client][:city],
        :state => params[:client][:state],
        :zip => params[:client][:zip]
      )

      super
    end
  end

  scope :all, :default => true
  scope :pending
  scope :accepted
  scope :declined

  action_item :only => :show do
    link_to "Print PDF", pdf_admin_proposal_path(proposal)
  end

  member_action :pdf do
    @proposal = Proposal.find(resource)
    respond_to do |format|
      format.html do
          render :pdf         => "#{@proposal.number}_#{@proposal.client.name}",
                 :wkhtmltopdf => '/usr/bin/wkhtmltopdf', # path to binary
                 :header      => {:center => "Proposal for #{@proposal.client.name}"},
                 :margin      => {:bottom         => 10,
                                  :left           => 10,
                                  :right          => 10}
      end
#      format.pdf do
#          render :pdf         => "#{@proposal.number}_#{@proposal.client.name}",
#                 :layout      => 'pdf.html' # use 'pdf.html' for a pdf.html.erb file
#      end
    end
  end

  index do
    selectable_column
    column "ID", :sortable => :number do |prop|
      link_to prop.number, admin_proposal_path(prop)
    end
    column :client
    column("Status") {|proposal| status_tag(proposal.status) }
    column "Method", :est_method
    column :customer_type
    column "Salesperson", :employee
    column "Created On", :created_at
  end

	show :title => :number do
		attributes_table do
			row ("Proposal ID") {resource.number}
      row :client
			row :status
			row :est_method
			row :decision_date
			row :customer_type
      row ("Salesperson") {resource.employee}
			row :created_at
			row :updated_at
		end

		panel "Locations" do
    	table_for proposal.locations do
				column ("Name") do |resource|
          link_to(resource.name, admin_location_path(resource))
        end
				column :address
        column :city
        column :state
        column :zip
    	end
  	end

	  panel "Work Orders" do
    	table_for proposal.work_orders do
			  column("") do |resource| 
          span link_to(image_tag('application_edit.png', :title => 'Edit'), edit_admin_work_order_path(resource))	if controller.current_ability.can? :edit, WorkOrder
          span link_to(image_tag('print.png', :title => 'Print'), pdf_admin_work_order_path(resource)) if controller.current_ability.can? :manage, WorkOrder
        end
			  column ("ID") do |resource|
          link_to(resource.number, admin_work_order_path(resource))	if controller.current_ability.can? :show, WorkOrder
        end
			  column :level
        column :location
			  column :date_required
			  column "Created On", :created_at
			  column "Updated On", :updated_at
    	end

      if resource.status == "Accepted"
        div do
		      link_to "Add Work Order", new_admin_work_order_path().to_s, # + "?&work_order[proposal_id]=#{proposal.id}"
            :class => "panel_button"
      	end
      end
    end

    active_admin_comments
  end

  form :partial => "form"

  filter :number, :label => "Proposal ID"
  filter :client
  filter :status, :as => :select, :collection => ["Pending", "Accepted", "Declined"]
  filter :employee, :label => "Salesperson"
  filter :est_method
  filter :customer_type, :as => :check_boxes, :collection => ["Residential", "Commercial", "Government", "General Contractor"]
  filter :decision_date
  filter :created_at, :label => "Created On"
  filter :updated_at, :label => "Updated On"


end
