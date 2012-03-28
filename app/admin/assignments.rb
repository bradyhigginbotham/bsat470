ActiveAdmin.register Assignment do
  menu :if => proc{ can?(:manage, Assignment) }     
  controller.authorize_resource

  form :partial => "form"
end
