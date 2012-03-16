ActiveAdmin.register Client do
  menu :priority => 3, :if => proc{ can?(:manage, Client) }     
  controller.authorize_resource

  scope :all, :default => true
  scope :will

  index do
    column "ID", :number
    column "Name", :sortable => :name do |client|
      link_to client.name, admin_client_path(client)
    end
    column :email
    column "Address", :billing_address
  end

  show :title => :name do
    attributes_table do
      row :number
      row :name
      row ("Email") do |resource|
        mail_to(resource.email)
      end
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
				column ("ID") do |resource|
          link_to(resource.number, admin_proposal_path(resource))	if controller.current_ability.can? :show, Proposal
        end
        column("Status") {|proposal| status_tag('accepted') }
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
      f.input :number, :as => :hidden
      f.input :name
  		f.input :email
      f.input :phone
      f.input :fax
      f.input :billing_name
      f.input :billing_address
    end

    f.semantic_fields_for :location do |p|
      p.inputs "Locations" do
        p.input :name
        p.input :address
      end
    end

    f.buttons
  end

  filter :number, :label => "Client ID"
  filter :name
  filter :email
  filter :created_at
  filter :updated_at
end
