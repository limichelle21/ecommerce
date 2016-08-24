class ChargesController < ApplicationController

require 'stripe'
Stripe.api_key = ENV['stripe_api_key']

	# show a credit card form using Checkout
	def new
	end

	# create the actual charge by calling Stripe API
	def create
		# amount in cents

		@amount = current_order.subtotal * 100

		#create customer in Stripe
		@customer = Stripe::Customer.create(
			email: params[:email],
			source: params[:stripeToken]
			)

		# create a customer in ecommerce app - how to make sure customer ID is same as Stripe Customer ID?
		@customer = params[:customer_id].present? ? @customer.assign_attributes(customer_params) : current_store.customers.build(customer_params)
		@customer.save

		#create the charge using customer data returned

		charge = Stripe::Charge.create(
			customer: @customer.id,
			amount: @amount,
			description: 'eCommerce Stripe Customer',
			currency: 'usd'
			)

		@order = current_store.orders.build(order_params) # how to ensure the Charge ID from above is passed?
		@order.save

		flash[:notice] = "Thanks for placing your order."
		clear_cart
		redirect_to store_confirmation_path
		
		# if charge was successful or not

		rescue Stripe::CardError => e 
			flash[:error] = e.message
			redirect_to new_store_charge_path
			flash[:notice] = "Please try again"
	
	end

	private

	  def clear_cart
	  	session["current_order_id_#{current_store.id}"] = nil
	  	redirect_to store_path
	  end

	  def customer_params
	  	params.require(:customer).permit(:name, :street_address, :city, :state, :zip_code, :phone_number, :email)
	  end

	  def order_params
 		params.require(:order).permit(:customer, :charge, :store, :total, :completed, :date_paid)
	  end	

end
