class StoresController < ApplicationController

layout 'customer'

skip_before_action :current_order

	def show
		@store = Store.friendly.find(params[:store_id])
	end


end


