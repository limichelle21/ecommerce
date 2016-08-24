class Customer::SessionsController < CustomerController

	def new
	end

	def create
		customer = Customer.find_by(email: params[:session][:email].downcase)

		if customer && customer.authenticate(params[:session][:password])
			create_session(customer)
			flash[:notice] = "Welcome, #{customer.name!}"
			redirect_to store_products_path
		else
			flash[:alert] = "Invalid email/password combination"
			render :new
		end
	end

	def destroy
		destroy_session(current_user)
		flash[:notice] = "You've been logged out successfully."
		redirect_to store_products_path
	end

end