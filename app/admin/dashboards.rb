ActiveAdmin::Dashboards.build do

  section "Records", :if => Proc.new { current_admin_user.department.title != "Labor" } do
    div :id => "chart_container" do
      render 'records'
		end
  end


	section "Proposals", :if => Proc.new { current_admin_user.department.title != "Labor" } do
		div :id => "chart_container" do
			render 'proposals'
		end
	end

	section "Account Information", :if => Proc.new { current_admin_user.department.title == "Labor" } do
    div :style => "width: 625px" do
      ul :style => "list-style-type: none" do
        li raw "<b>ID:</b> " + current_employee.number
        li raw "<b>Name:</b> " + current_employee.name
        li raw "<b>Phone:</b> " + current_employee.phone
        li raw "<b>Department:</b> " + current_employee.department.title
        li raw "<b>Supervisor:</b> " + current_employee.supervisor.name
      end
    end
  end

  section "Current Assignments", :priority => 2, :if => Proc.new { current_admin_user.department.title == "Labor" } do
    table_for LaborAssignment.where("labor_assignments.employee_id, ?", current_employee.id).order('assignment_id desc').each do |assignment|
      column :rate
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
