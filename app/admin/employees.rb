ActiveAdmin.register Employee do

  menu :if => proc{ can?(:manage, Employee) }     
  controller.authorize_resource 

	index do
    column "ID", :id
    column "Name", :sortable => :full_name do |emp|
      link_to emp.full_name, admin_employee_path(emp)
    end	
		column :email
		column :role
	end
	
	show do
		attributes_table do
			row ("Employee ID") {resource.id}
			row ("Name") {resource.full_name}
			row :email
			row :phone 
			row :created_at
			row :updated_at
		end
	end
	
	form do |f|
		f.inputs "Employee Details" do
      f.input :full_name
			f.input :email
			f.input :phone
		end
		f.buttons
	end

	filter :full_name, :label => "Name"
	filter :email

end
