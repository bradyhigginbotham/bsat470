ActiveAdmin.register Proposal do
	#scope :pending

  actions :all, :only => :show, :if => proc{ can?(:manage, Proposal) }

  menu :if => proc{ can?(:manage, Proposal) }     
  controller.authorize_resource 

	index do
    column "No.", :sortable => :proposal_num do |p|
      link_to p.proposal_num, admin_proposal_path(p)
    end	
    column "Client", :sortable => :client do |c|
      p c.client.full_name
    end	
		column "Supervisor", :employee
		column :status, :sortable => :status do |c|
      div :class => c.status do
				c.status
			end
		end
		column :customer_type
		column "Locations", :location_num
		column "Method", :est_method
		column :decision_date
		column "Created On", :created_at
	end

	show do
    attributes_table do
			row ("Proposal No.") {resource.proposal_num}
			row :client
			row :customer_type
			row :status
			row ("No. of Locations") {resource.location_num}
			row ("Method") {resource.est_method}
			row :decision_date
			row ("Created On") {resource.created_at}
			row ("Supervisor") {resource.account}
    end
		active_admin_comments

# Tasks

	end

  form :partial => "form"

#	form do |f|
#		f.inputs "Employee Details" do
#      f.input :proposal_num
#		end


#		f.has_many :locations do |app_f|
#				app_f.input :name
#		    app_f.input :address

#				app_f.has_many :tasks do |t|
#					t.inputs "Tasks" do
#						t.input :est_hours
#					end
#				end

#		    if !app_f.object.nil?
#		      # show the destroy checkbox only if it is an existing appointment
#		      # else, there's already dynamic JS to add / remove new appointments
#		      app_f.input :_destroy, :as => :boolean, :label => "Destroy?"
#		    end
#		end
#		f.buttons
#	end
  
	filter :proposal_num, :label => "Proposal No."
	filter :client
	filter :account
	filter :status, :as => :select, :collection => ["Pending","Accepted","Declined"]
	filter :customer_type, :as => :select, :collection => ["General Contractor", "Commercial", "Government", "Residential"]
	filter :location_num, :label => "Locations"
	filter :est_method, :label => "Method"
	filter :decision_date
	filter :created_at

end
