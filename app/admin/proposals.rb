ActiveAdmin.register Proposal do
  menu :priority => 4, :if => proc{ can?(:manage, Proposal) }     
  controller.authorize_resource

  scope :all, :default => true
  scope :pending
  scope :accepted
  scope :declined

 form :partial => "form"


end
