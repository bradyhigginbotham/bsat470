ActiveAdmin.register WorkOrder, :as => "Work Order"  do
 
  menu :label => "Work Orders", :if => proc{ can?(:manage, WorkOrder) }     
  controller.authorize_resource 

end
