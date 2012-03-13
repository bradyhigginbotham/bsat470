ActiveAdmin.register Employee do
  menu :priority => 2, :label => "Administration", :if => proc{ can?(:manage, :all) }     
  controller.authorize_resource

  scope :all, :default => true
  scope :management
  scope :sales
  scope :labor

  index do
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
			row :email
			row :phone
			row ("Administrator") {resource.admin}
			row :supervisor
			row ("Dept.") {resource.department}
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
			row :created_at
			row :updated_at
		end

    active_admin_comments
	end
  
  form do |f|
    f.inputs "Details" do
      f.input :number
      f.input :name
  		f.input :email
      f.input :phone
      f.input :supervisor
			f.input :department, :required => true, :include_blank => false
      f.input :admin, :label => "Administrator"
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
