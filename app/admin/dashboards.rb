ActiveAdmin::Dashboards.build do

#  menu :if => proc{ can?(:manage, :all) }     
#  controller.authorize_resource 

  section "Statistics" do
#  	div "Number of Clients: " do
#			link_to("#{Client.select("DISTINCT clients.client_num").count}", admin_clients_path())
#		end
#  	div "Number of Proposals: " do
#			link_to("#{Proposal.select("DISTINCT proposals.proposal_num").count}", admin_proposals_path())
#		end
    div :id => "chart_container" do
      render 'stats'
		end
  end


	section "Proposals", :if => Proc.new { current_admin_user.role == "Admin" } do
		div :id => "chart_container" do
			render 'proposals'
		end
	end

#	section "Recent Proposals" do
#	  Proposal.all.collect do |p|
#	    div link_to(p.proposal_num, admin_proposal_path(p))
#	  end
#	end
  
  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.
  
  # == Conditionally Display
  # Provide a method name or Proc object to conditionally render a section at run time.
  #
  # section "Membership Summary", :if => :memberships_enabled?
  # section "Membership Summary", :if => Proc.new { current_admin_user.account.memberships.any? }

end
