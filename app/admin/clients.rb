ActiveAdmin.register Client do
  menu :priority => 3

  index do
    column "ID", :number
    column "Name", :sortable => :name do |client|
      link_to client.name, admin_client_path(client)
    end
    column :email
  end

  show :title => :name do
    attributes_table do
      row :number
      row :name
      row :email
      row :phone
      row :fax
      row :billing_name
      row :billing_address
      row :created_at
      row :updated_at
    end

		panel "Locations" do
    	table_for client.locations do
				column :name
				column :address
				column("") do |resource| 
 #         link_to(image_tag('application_edit.png', :title => 'Edit'), edit_admin_location_path(resource))	if controller.current_ability.can? :edit, Location
        end
    	end
  	end

		panel "Proposals" do
    	table_for client.proposals do
				column "ID", :proposal_num
				column :status
				column :customer_type
				column "Created On", :created_at
				column :decision_date
				column("") do |resource| 
   #       link_to(image_tag('application_edit.png', :title => 'Edit'), edit_admin_proposal_path(resource))	if controller.current_ability.can? :edit, WorkOrder
        end
    	end
			link_to "Add Proposal", new_admin_proposal_path().to_s + "?&proposal[client_id]=#{client.id}", :class => "panel_button"
  	end

    active_admin_comments
  end

  form do |f|
    f.inputs "Details" do
      f.input :number
      f.input :name
  		f.input :email
      f.input :phone
      f.input :fax
      f.input :billing_name
      f.input :billing_address
    end

    f.buttons
  end

  filter :number, :label => "Client ID"
  filter :name
  filter :email
  filter :created_at
  filter :updated_at
end
