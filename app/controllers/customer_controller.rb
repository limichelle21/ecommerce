class CustomerController < ApplicationController
	layout 'customer'

	before_action :authenticate_customer!

	session[:current_user_id] = user.id 
	
end
