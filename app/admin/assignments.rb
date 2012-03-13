ActiveAdmin.register Assignment do
  menu :parent => "Assignments", :label => "General", :if => proc{ can?(:manage, Assignment) }     
  controller.authorize_resource
end
