ActiveAdmin.register Material do
  menu :parent => "Assets"

  index do
    column :id
    column "Material", :sortable => :name do |mat|
      link_to mat.name, admin_material_path(mat)
    end	
    column :unit_cost
    column :quantity
  end

  show :title => :name do
    attributes_table do
      row :name
      row :unit_cost
      row :quantity
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
  		f.input :unit_cost
      f.input :quantity
    end
    f.buttons
  end

end
