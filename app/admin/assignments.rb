ActiveAdmin.register Assignment do
  menu :if => proc{ can?(:manage, Assignment) }     
  controller.authorize_resource

  controller do
    def new
      super do
        resource.material_assignments.build
        resource.labor_assignments.build
      end
    end
  end

  form :partial => "form"
end
