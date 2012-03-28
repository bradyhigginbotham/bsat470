class WorkOrdersController < ApplicationController
	def get_location  
    work_order = WorkOrder.find(params[:id])
		if @location = work_order.location
			render :json => @location
		else
			render :text => "record_not_found"
		end
	end
end
