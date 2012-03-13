class ClientsController < ApplicationController
	def show
		@client = Client.find(params[:id])
	end

	def ajax_call
		if @client = Client.find(params[:id])
			render :json => @client
		else
			render :text => "record_not_found"
		end
	end

  def next_id
    if last_client = Client.last
      id = last_client.number
      id.slice!(0)
      count = id.count("0")
      id = (id.to_i + 1).to_s
      for i in 0...count do
        id = "0" + id
      end
      @next_id = "C" + id
    else
      @next_id = "C001" # first client
    end

    render :json => @next_id
  end
end
