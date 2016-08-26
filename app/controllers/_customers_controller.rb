class CustomersController < ApplicationController
	layout 'customer'

	# before_action :authenticate_customer!

	# session[:current_user_id] = user.id 
	skip_before_action :current_order


	def new
		@customer = Customer.new
	end

	#Customer Sign up

	def create
		@store = current_store
		@customer = @store.customers.build(customer_params)

		if @customer.save
			flash[:notice] = "Welcome to #{current_store.name}!"
			
			create_session(@customer)
			# current_user = @customer
			# create_session(current_user)
						
			redirect_to store_products_path
		else
			flash[:alert] = "There was an error creating your account. Please try again."
			render :new
		end
	end


	private

	def customer_params
		params.require(:customer).permit(:email, :password, :password_confirmation, :type, :name, :street_address, :city, :state, :zip_code, :phone_number)
	end

	# def create_session(user)
	# 	session[:user_id] = user.id
	# end


end
