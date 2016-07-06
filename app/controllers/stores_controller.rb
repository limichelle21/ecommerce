class StoresController < ApplicationController

	def new
		@store = Store.new
	end


	def show
		@store = Store.find(params[:id])
	end



end


