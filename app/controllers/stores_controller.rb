class StoresController < ApplicationController

	def new
		@store = Store.new
	end

	def show
		@store = Store.friendly.find(params[:store_id])
	end


end


