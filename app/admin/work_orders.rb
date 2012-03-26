ActiveAdmin.register WorkOrder do
  menu :label => "Work Orders", :priority => 5, :if => proc{ can?(:manage, WorkOrder) }     
  controller.authorize_resource

  controller do
    def create
      params[:tasks].each do |key, task|
        @task = Task.find(task[:id])
        @task.update_attributes(
          :title => task[:title],
          :status => task[:status],
          :sqft => task[:sqft],
          :price_per_sqft => task[:price_per_sqft],
          :est_hours => task[:est_hours],
          :date_completed => task[:date_completed],
          :location_id => task[:location_id]
        )
      end

      super
    end

    def update
      params[:tasks].each do |key, task|
        @task = Task.find(task[:id])
        @task.update_attributes(
          :title => task[:title],
          :status => task[:status],
          :sqft => task[:sqft],
          :price_per_sqft => task[:price_per_sqft],
          :est_hours => task[:est_hours],
          :date_completed => task[:date_completed],
          :location_id => task[:location_id]
        )
      end

      super
    end

  end

  form :partial => "form"

end
