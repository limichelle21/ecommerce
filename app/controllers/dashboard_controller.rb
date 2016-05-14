class DashboardController < ApplicationController

	layout 'dashboard'
	# to correspond with the dashboard layouts for view 

	# before_action :authenticate_owner!

	# def check_if_owner
	# 	unless current_user.owner?
	# 		redirect_to root_path
	# 	end
	# end

end