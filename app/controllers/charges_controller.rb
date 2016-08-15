class ChargesController < ApplicationController

require 'stripe'
Stripe.api_key = ENV['stripe_api_key']

	# show a credit card form using Checkout
	def new
	end

	# create the actual charge by calling Stripe API
	def create
		# amount in cents

		@amount = current_order.subtotal

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



end
