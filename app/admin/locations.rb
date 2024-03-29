ActiveAdmin.register Location do
#  belongs_to :client

  menu false

  show :title => :name do
    attributes_table do
      row :name
      row ("Address") do |resource|
        raw resource.address + "<br />" + "#{resource.city}, #{resource.state} #{resource.zip}"
      end
      row :client
      row :created_at
      row :updated_at
    end

		panel "Tasks" do
    	table_for location.tasks do
        column :title
        column("Status") {|task| status_tag(task.status) }
        column :sqft
        column :price_per_sqft
        column :est_hours
        column ("Created On") {|task| task.created_at.strftime("%B %d, %Y")}
        column ("Updated On") {|task| task.updated_at.strftime("%B %d, %Y")}
    	end
  	end

    active_admin_comments
  end

  form do |f|
    f.inputs "Details" do
      f.input :client
      f.input :name
      f.input :address
      f.input :city
      f.input :state
      f.input :zip
    end

    f.buttons
  end

end
