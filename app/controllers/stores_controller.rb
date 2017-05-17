class StoresController < ApplicationController

layout 'customer'

	def show
		@store = Store.friendly.find(params[:store_id])
	end


end


