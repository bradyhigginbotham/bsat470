ActiveAdmin.register Material do
  menu :parent => "Assets", :if => proc{ can?(:manage, Material) }     
  controller.authorize_resource

  scope :all, :default => true
  scope "Reorder", :low_quantity

  index do
    column :id
    column "Material", :sortable => :name do |mat|
      link_to mat.name, admin_material_path(mat)
    end	
    column :unit_cost
    column "Quantity", :sortable => :quantity do |mat|
      if mat.quantity < 10      
        div :style => "font-weight: bold; color: red" do        
          mat.quantity
        end
      else
        mat.quantity
      end
    end	
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

  filter :name
  filter :unit_cost
  filter :quantity

end
