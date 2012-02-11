ActiveAdmin.register Client do

  menu :if => proc{ can?(:manage, Client) }     
  controller.authorize_resource 

	index do
    column "No.", :client_num
    column "Name", :sortable => :full_name do |client|
      link_to client.full_name, admin_client_path(client)
    end	
		column :email
	end

  show do
    attributes_table do
			row ("Client No.") {resource.client_num}
			row ("Name") {resource.full_name}
			row :email
			row :billing_name
			row :billing_address
    end

		panel "Locations" do
    	table_for client.locations do
				column :name
				column :address
				column("") do |resource| 
          link_to(image_tag('application_edit.png', :title => 'Edit'), edit_admin_proposal_path(resource))	if controller.current_ability.can? :edit, Location
        end
    	end
  	end

		panel "Proposals" do
    	table_for client.proposals do
				column "No.", :proposal_num
				column :status
				column :customer_type
				column "Created On", :created_at
				column :decision_date
				column("") do |resource| 
          link_to(image_tag('application_edit.png', :title => 'Edit'), edit_admin_proposal_path(resource))	if controller.current_ability.can? :edit, WorkOrder
        end
    	end
			link_to "Add Proposal", new_admin_proposal_path().to_s + "?&proposal[client_id]=#{client.id}", :class => "panel_button"
  	end
  end

  form do |f|
    f.inputs "Details" do
			f.input :client_num, :label => "Client No."
      f.input :full_name
  		f.input :email
			f.input :billing_name
			f.input :billing_address
    end
    f.buttons
  end 	

	filter :client_num, :label => "Client No."
	filter :full_name, :label => "Name"
	filter :email  

end
