ActiveAdmin.register Employee do
  menu :priority => 2, :label => "Administration", :if => proc{ can?(:manage, :all) }     
  controller.authorize_resource

  scope :all, :default => true
  scope :management
  scope :sales
  scope :labor

  index do
    selectable_column
    column "ID", :number
    column "Name", :sortable => :name do |emp|
      link_to emp.name, admin_employee_path(emp)
    end	
    column :email
    column :department
    column "Admin?", :admin
  end

	show :title => :name do
		attributes_table do
			row ("Employee ID") {resource.number}
			row :name
      row ("Email") do |resource|
        mail_to(resource.email)
      end
			row :phone
			row ("Administrator") {resource.admin}
			row :supervisor
			row ("Department") {resource.department}
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
			row :created_at
			row :updated_at
		end

    if resource.department.title == "Sales"
		  panel "Proposals" do
      	table_for employee.proposals do
				  column("") do |resource| 
            span link_to(image_tag('application_edit.png', :title => 'Edit'), edit_admin_proposal_path(resource))	if controller.current_ability.can? :edit, Proposal
            span link_to(image_tag('print.png', :title => 'Print'), pdf_admin_proposal_path(resource))	if controller.current_ability.can? :manage, Proposal
          end
				  column ("ID") do |resource|
            link_to(resource.number, admin_proposal_path(resource))	if controller.current_ability.can? :show, Proposal
          end
          column("Status") {|proposal| status_tag(proposal.status) }
				  column :customer_type
				  column "Created On", :created_at
				  column :decision_date
      	end
        div do
			    link_to "Add Proposal", new_admin_proposal_path().to_s + "?&proposal[employee_id]=#{employee.id}", :class => "panel_button"
      	end
      end
    end

    if resource.department.title == "Management"
		  panel "Work Orders" do
      	table_for employee.work_orders do
				  column("") do |resource| 
            span link_to(image_tag('application_edit.png', :title => 'Edit'), edit_admin_work_order_path(resource))	if controller.current_ability.can? :edit, WorkOrder
            span link_to(image_tag('print.png', :title => 'Print'), pdf_admin_work_order_path(resource))	if controller.current_ability.can? :manage, WorkOrder
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
        div do
			    link_to "Add Work Order", new_admin_work_order_path().to_s + "?&work_order[employee_id]=#{employee.id}", :class => "panel_button"
      	end
      end
    end


    active_admin_comments
	end
  
  form do |f|
    f.inputs "Details" do
      f.input :name
  		f.input :email
      f.input :phone
      f.input :supervisor
			f.input :department, :required => true, :include_blank => false
      f.input :admin, :label => "Administrator", :input_html => { :checked => 'checked' }
      f.input :number, :as => :hidden, :value => f.object.next_id

    end
    f.buttons
  end

  filter :number, :label => "Employee ID"
  filter :name
  filter :email
  filter :phone
  filter :supervisor
  filter :admin

end
