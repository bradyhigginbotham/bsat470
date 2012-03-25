class TasksController < ApplicationController
	def ajax_call
		if @tasks = Tasks.where("location_id = ?", params[:id])
			render :json => @tasks
		else
			render :text => "record_not_found"
		end
	end
end
