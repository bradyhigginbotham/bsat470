ActiveAdmin.register WorkOrder do
  menu :label => "Work Orders", :priority => 5, :if => proc{ can?(:manage, WorkOrder) }     
  controller.authorize_resource

  form :partial => "form"
#  form do |f|
#    f.inputs "Details" do
#      f.input :proposal, :as => :select, :collection => Proposal.all.collect{|p| [p.number, p.id]}
#      f.input :employee
#    end
#  end
end
