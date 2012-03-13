ActiveAdmin.register MaterialAssignment do
  menu :parent => "Assignments", :label => "Material", :if => proc{ can?(:manage, MaterialAssignment) }     
  controller.authorize_resource
end
