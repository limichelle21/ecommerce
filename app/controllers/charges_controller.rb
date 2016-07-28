class ChargesController < ApplicationController

	# show a credit card form using Checkout
	def new
	end

	# create the actual charge by calling Stripe API
	def create

		# amount in cents

		# want the @amount to be current_order.subtotal. 

		@amount = 2500

		#create customer in Stripe
		customer = Stripe::Customer.create(
			email: params[:stripeEmail],
			source: params[:stripeToken]
			)

		#create the charge using customer data returned

		charge = Stripe::Charge.create(
			customer: customer.id,
			amount: @amount,
			description: 'eCommerce Stripe Customer',
			currency: 'usd'
			)

		flash[:notice] = "Thanks for placing your order."
		clear_cart
		redirect_to store_path
		
		# if charge was successful or not

		rescue Stripe::CardError => e 
			flash[:error] = e.message
			redirect_to new_store_charge_path
			flash[:notice] = "Please try again"
	
	end


end
