class TasksController < ApplicationController
	def ajax_call
		if @tasks = Task.where("location_id = ?", params[:id])
			render :json => @tasks
		else
			render :text => "record_not_found"
		end
	end

	def assignments_ajax_call
    if work_order = WorkOrder.find(params[:id])
		  if @tasks = Task.where("location_id = ?", work_order.location_id)
			  render :json => @tasks
		  else
			  render :text => "record_not_found"
		  end
    end
	end

end
