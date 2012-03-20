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
    	end
  	end

    active_admin_comments
  end

end
