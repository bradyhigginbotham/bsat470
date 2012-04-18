ActiveAdmin.register Invoice do
  actions :all, :except => :new
  controller.authorize_resource

  action_item :only => :show do
    link_to "Print PDF", pdf_admin_invoice_path(invoice)
  end

  scope :all, :default => true
  scope :paid
  scope :unpaid

  member_action :pdf do
    @tasks = [];
    @invoice = Invoice.find(resource)
    @work_orders = WorkOrder.where("invoice_id = ?", @invoice.id)

    @work_orders.each do |wo|
      wo_tasks = Task.where("work_order_id = ?", wo.id)
      wo_tasks.each do |task|      
        @tasks.push(task)
      end
    end

    respond_to do |format|
      format.html do
          render :pdf         => "#{@invoice.number}_#{@invoice.client.name}",
                 :wkhtmltopdf => '/usr/bin/wkhtmltopdf', # path to binary
                 :header      => {:center => "Invoice for #{@invoice.client.name}"},
                 :margin      => {:bottom         => 10,
                                  :left           => 10,
                                  :right          => 10}
      end
    end
  end

  index do
    selectable_column
    column "ID", :sortable => :number do |inv|
      link_to inv.number, admin_invoice_path(inv)
    end
    column "Client", :sortable => :client do |inv|
      link_to inv.client.name, admin_client_path(inv.client)
    end
    column "Status", :sortable => :paid do |inv|
      if inv.paid
        status_tag("Paid")
      else
        status_tag("Unpaid")
      end
    end
    column :start_date
    column :end_date
    column "Created On", :created_at
    column "Updated On", :updated_at
  end

  show :title => :number do
    attributes_table do
      row ("Invoice ID") {resource.number}
      row :client
      row :paid
      row :start_date
      row :end_date
      row :created_at
      row :updated_at
      row ("Proposal") do |resource|
        if wo = WorkOrder.find_by_invoice_id(resource.id)
          proposal = Proposal.find(wo.proposal_id)
          link_to(proposal.number, admin_proposal_path(proposal))
        end
      end
    end

		panel "Work Orders" do
    	table_for invoice.work_orders do
        column :number
        column :level
        column ("Status") {status_tag("Complete")}
        column :location
        column "Supervisor", :employee
			  column "Created On", :created_at
			  column "Updated On", :updated_at
    	end
  	end

    active_admin_comments
  end

  form do |f|
    f.inputs "Details" do
      f.input :start_date, :as => :datepicker
      f.input :end_date, :as => :datepicker
  		f.input :paid
    end

    f.buttons
  end

end
