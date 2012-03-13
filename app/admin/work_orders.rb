ActiveAdmin.register WorkOrder do
  menu :label => "Work Orders", :priority => 5, :if => proc{ can?(:manage, WorkOrder) }     
  controller.authorize_resource
end
