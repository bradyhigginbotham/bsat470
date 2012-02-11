class ClientsController < ApplicationController
	def show
		@client = Client.find(params[:id])
	end

	def ajax_update
		if @client = Client.find(params[:id])
			render :json => @client
		else
			render :text => "record_not_found"
		end
	end
end
