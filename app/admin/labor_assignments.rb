ActiveAdmin.register LaborAssignment do
  menu :parent => "Assignments", :label => "Labor", :if => proc{ can?(:manage, LaborAssignment) }     
  controller.authorize_resource
end
