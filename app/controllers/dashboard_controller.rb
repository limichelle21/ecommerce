class DashboardController < ApplicationController

	layout 'dashboard'
	# to correspond with the dashboard layouts for view 

	# before_action :check_if_owner

	# check if the current user is the Store's owner. If not, redirect to root path

	def check_if_owner
		if current_user == Store.find(params[:id]).owner
			redirect_to dashboard_store_products_path
		else
			redirect_to root_path
		end
	end

 


end