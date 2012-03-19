ActiveAdmin.register Proposal do
  menu :priority => 4, :if => proc{ can?(:manage, Proposal) }     
  controller.authorize_resource


  controller do
    def create
      if params[:client_record] == 'new'
        @client = Client.create!(
          :number => params[:client][:number],
          :name => params[:client][:name],
          :email => params[:client][:email],
          :billing_address => params[:client][:billing_address],
          :city => params[:client][:city],
          :state => params[:client][:state],
          :zip => params[:client][:zip]
        )

        #params[:client_id] = @client.id
      else # existing
        @client = Client.find(params[:client][:id])
        @client.update_attributes(
          :number => params[:client][:number],
          :name => params[:client][:name],
          :email => params[:client][:email],
          :billing_address => params[:client][:billing_address],
          :city => params[:client][:city],
          :state => params[:client][:state],
          :zip => params[:client][:zip]
        )
      end

      super
    end
        
    def new
      super do
        resource.locations.build
        resource.locations.first.tasks.build
      end
    end
  end

  scope :all, :default => true
  scope :pending
  scope :accepted
  scope :declined

  action_item :only => :show do
    link_to "Print PDF", pdf_admin_proposal_path(proposal) if proposal.status != "Pending"
  end

  member_action :pdf do
    @proposal = Proposal.find(resource)
    respond_to do |format|
      format.html do
          render :pdf         => "#{@proposal.number}_#{@proposal.client.name}",
                 :wkhtmltopdf => '/usr/bin/wkhtmltopdf', # path to binary
                 :header      => {:center => "text"},
                 :margin      => {:bottom         => 0,
                                  :left           => 0,
                                  :right          => 0}
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
    column "State", :status
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

		panel "Work Orders" do
    	table_for proposal.work_orders do
				column ("ID") do |resource|
          link_to(resource.number, admin_work_order_path(resource))	if controller.current_ability.can? :show, WorkOrder
        end
				column "Manager", :employee
        column :date_required
        column :notes
				column "Created On", :created_at
				column("") do |resource| 
   #       link_to(image_tag('application_edit.png', :title => 'Edit'), edit_admin_proposal_path(resource))	if controller.current_ability.can? :edit, WorkOrder
        end
    	end
			link_to "Add Work Order", new_admin_work_order_path().to_s + "?&work_order[proposal_id]=#{proposal.id}", :class => "panel_button"
  	end


    active_admin_comments
  end

 form :partial => "form"

  filter :client
  filter :number, :label => "ID"
  filter :status
  filter :decision_date
  filter :est_method
  filter :customer_type
  filter :employee
  filter :created_at
  filter :updated_at


end
