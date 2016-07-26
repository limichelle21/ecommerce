class StoresController < ApplicationController


	def show
		@store = Store.friendly.find(params[:store_id])
	end


end


