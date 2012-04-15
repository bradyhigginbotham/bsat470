ActiveAdmin.register Client do
  menu :priority => 3, :if => proc{ can?(:manage, Client) }     
  controller.authorize_resource

  index do
    selectable_column
    column "ID", :number
    column "Name", :sortable => :name do |client|
      link_to client.name, admin_client_path(client)
    end
    column :email
    column "Address", :billing_address
  end

  show :title => :name do
    attributes_table do
      row ("Client ID") {resource.number}
      row :name
      row ("Email") do |resource|
        mail_to(resource.email)
      end
      row :phone
      row :billing_name
      row ("Billing Address") do |resource|
        raw resource.billing_address + "<br />" + "#{resource.city}, #{resource.state} #{resource.zip}"
      end
      row :created_at
      row :updated_at
    end

		panel "Locations" do
    	table_for client.locations do
				column("") do |resource| 
          link_to(image_tag('application_edit.png', :title => 'Edit'), edit_admin_location_path(resource))	if controller.current_ability.can? :manage, Client
        end
				column ("Name") do |resource|
          link_to(resource.name, admin_location_path(resource))	if controller.current_ability.can? :manage, Client
        end
				column :address
        column :city
        column :state
        column :zip
    	end

      div do
        link_to "Add Location", new_admin_location_path().to_s + "?&location[client_id]=#{client.id}", :class => "panel_button"
      end
  	end

		panel "Proposals" do
    	table_for client.proposals do
				column("") do |resource| 
          span link_to(image_tag('application_edit.png', :title => 'Edit'), edit_admin_proposal_path(resource))	if controller.current_ability.can? :manage, Proposal
          span link_to(image_tag('print.png', :title => 'Print'), pdf_admin_proposal_path(resource))	if controller.current_ability.can? :manage, Proposal
        end
				column ("ID") do |resource|
          link_to(resource.number, admin_proposal_path(resource))	if controller.current_ability.can? :manage, Proposal
        end
        column("Status") {|proposal| status_tag(proposal.status) }
				column :customer_type
				column "Created On", :created_at
				column :decision_date
    	end

      div do
        link_to "Add Proposal", new_admin_proposal_path().to_s + "?&proposal[client_id]=#{client.id}", :class => "panel_button"
      end
  	end

    active_admin_comments
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
  		f.input :email
      f.input :phone
      f.input :billing_name
      f.input :billing_address
      f.input :city
      f.input :state
      f.input :zip
      if f.object.new_record?
        f.input :number, :as => :hidden, :value => f.object.next_id
      else
        f.input :number, :as => :hidden, :value => f.object.number
      end
    end

    f.semantic_fields_for :locations do |p|
      p.inputs "Locations" do
        p.input :name
        p.input :address
        p.input :city
        p.input :state
        p.input :zip
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
