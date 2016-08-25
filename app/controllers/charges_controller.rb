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
		customer = Stripe::Customer.create(
			email: params[:email],
			source: params[:stripeToken]
			)


		@customer = Customer.where(email: params[:email])

		if current_user.present? 
			if @customer.email == current_user.email
				@customer.assign_attributes(customer_params)
				@customer.save!
			else
				flash[:alert] = "This email is associated with another account. Please sign into that account or provide a different email."
			end
		else
			@guest = guests.create(guest_params)
			@guest.save!
		end

		#create the charge in Stripe
		charge = Stripe::Charge.create(
			customer: @customer.id,
			amount: @amount,
			description: 'eCommerce Stripe Customer',
			currency: 'usd'
			)


		@order = current_store.orders.build(
			customer_id: @customer.id,
			guest_id: @guest.id,
			charge_id: charge.id,
			completed: true,
			total: @amount,
			date_paid: Date.today.to_s
			 )
		@order.save!



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
	  	params.permit(:name, :street_address, :city, :state, :zip_code, :phone_number, :email)
	  end

	  def guest_params
	  	params.permit(:name, :street_address, :city, :state, :zip_code, :phone_number, :email)
	  end



end
