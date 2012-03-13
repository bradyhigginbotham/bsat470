ActiveAdmin.register Vehicle do
  menu :parent => "Assets", :if => proc{ can?(:manage, Vehicle) }     
  controller.authorize_resource

  index do
    column :id
    column "Vehicle", :sortable => :make do |v|
      link_to v.make + ' ' + v.model, admin_vehicle_path(v)
    end	
    column :year
    column :checked_out
  end

  show :title => :model do
    attributes_table do
      row :make
      row :model
      row :year
      row :checked_out
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Details" do
      f.input :make
  		f.input :model
      f.input :year
      f.input :checked_out
    end
    f.buttons
  end

end
