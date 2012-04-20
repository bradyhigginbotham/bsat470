ActiveAdmin::Dashboards.build do
  section "Sales", :priority => 1, :if => Proc.new { current_admin_user.department.title == "Management" } do
    div :id => "chart_container" do
      render 'invoices'
		end
  end

  section "Records", :priority => 2, :if => Proc.new { current_admin_user.department.title != "Labor" } do
    div :id => "chart_container" do
      render 'records'
		end
  end

	section "Pie Charts", :priority => 3, :if => Proc.new { current_admin_user.department.title != "Labor" } do
		div :id => "chart_container" do
			render 'pies'
		end
	end

	section "Account Information", :priority => 1, :if => Proc.new { current_admin_user.department.title == "Labor" } do
    div :style => "width: 625px" do
      ul :style => "list-style-type: none" do
        li raw "<b>ID:</b> " + current_employee.number
        li raw "<b>Name:</b> " + current_employee.name
        li raw "<b>Phone:</b> " + current_employee.phone
        li raw "<b>Department:</b> " + current_employee.department.title
        if current_employee.supervisor
          li raw "<b>Supervisor:</b> " + current_employee.supervisor.name
        else
          li raw "<b>Supervisor:</b> N/A"
        end
      end
    end
  end

  section "Current Assignments", :priority => 2, :if => Proc.new { current_admin_user.department.title == "Labor" } do
    if current_employee.labor_assignments.any?
      table_for LaborAssignment.where("employee_id = ?", current_employee.id) do
        column ("Assignment") {|la| link_to(la.assignment.number, admin_assignment_path(la.assignment))}
        column ("Task") {|la| la.task.title}
        column ("Rate") {|la| number_to_currency(la.rate)}
        column :est_hours
        column :used_hours
      end
    else
      div "#{current_employee.name} has no assignments at the moment."
    end
  end
  
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
