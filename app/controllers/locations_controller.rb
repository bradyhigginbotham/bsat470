class LocationsController < ApplicationController
	def list
		if @locations = Location.where("proposal_id = ?", params[:id])
			render :json => @locations
		else
			render :text => "record_not_found"
		end
	end

	def ajax_call
		if @location = Location.find(params[:id])
			render :json => @location
		else
			render :text => "record_not_found"
		end
	end
end
