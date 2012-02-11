ActiveAdmin.register Account do

  menu :label => "Administration", :if => proc{ can?(:manage, Employee) }     
  controller.authorize_resource 


	index do
    column "ID", :id
    column "Name", :sortable => :full_name do |a|
      link_to a.full_name, admin_account_path(a)
    end	
		column :email
		column :role
		column :last_sign_in_at
		column :sign_in_count
	end

	show do
		attributes_table do
			row ("Admin ID") {resource.id}
			row ("Name") {resource.full_name}
			row :email
			row :role 
			row :current_sign_in_at
			row :last_sign_in_at
			row :sign_in_count
			row :created_at
			row :updated_at
		end

		panel "Proposals" do
    	table_for account.proposals do
				column "No.", :proposal_num
				column :status
				column :client
				column :customer_type
				column "Created On", :created_at
				column :decision_date
				column("") do |resource| 
          link_to(image_tag('application_edit.png', :title => 'Edit'), edit_admin_proposal_path(resource))	if controller.current_ability.can? :edit, Proposal
        end
    	end
  	end

		panel "Work Orders" do
    	table_for account.work_orders do
				column "No.", :order_num
				column :status
				column :notes
				column :date_required
				column "Created On", :created_at
				column("") do |resource| 
          link_to(image_tag('application_edit.png', :title => 'Edit'), edit_admin_work_order_path(resource))	if controller.current_ability.can? :edit, WorkOrder
        end
    	end
  	end
	end

	form do |f|
		f.inputs "Administrator Details" do
      f.input :full_name
			f.input :email
			f.input :role, :as => :select, :collection => ["Admin", "Supervisor", "Manager"], :include_blank => false
		end
		f.buttons
	end

	filter :full_name, :label => "Name"
	filter :email
	filter :role
	filter :created_at, :label => "Created On"

end
