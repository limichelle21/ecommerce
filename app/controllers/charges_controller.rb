class ChargesController < ApplicationController

layout 'customer'

require 'stripe'
Stripe.api_key = ENV['stripe_api_key']

	# show a credit card form using Checkout
	def new
	end

	# create the actual charge by calling Stripe API
	def create

		# amount in cents
		@amount = current_order.subtotal * 100

		#current_customer is a Devise helper method

		charge_params = {
			amount: @amount,
			description: 'eCommerce Stripe Customer',
			currency: 'usd'
		}

		order_params = {
			completed: true,
			price_in_cents: @amount,
			date_paid: Date.today.to_s
		}

		if current_customer.present?
			if current_customer.stripe_id.present?
				# retrieve Stripe customer
				customer = Stripe::Customer.retrieve(current_customer.stripe_id.to_s)
			else
				customer = Stripe::Customer.create(
					email: current_customer.email,
					source: params[:stripeToken]
					)
				current_customer.assign_attributes(stripe_id: customer.id)
			end
			current_customer.assign_attributes(customer_params)
			current_customer.save!
			charge_params[:customer] = customer["id"]
		else
			@guest = Guest.create(guest_params)
			@guest.save!
			charge_params[:source] = params[:stripeToken]
		end


		# create the charge in Stripe - this will charge the user's card
		charge = Stripe::Charge.create(charge_params)

		if current_customer.present?
			order_params[:charge_id] = charge.id
			order_params[:customer_id] = current_customer.id
      order_params[:price_in_cents] = @amount
			@order = current_store.orders.build(order_params)
		else
			order_params[:charge_id] = charge.id
			order_params[:guest] = @guest.id
      order_params[:price_in_cents] = @amount
			@order = current_store.orders.build(order_params)
		end

		@order.save!



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
	  	redirect_to store_confirmation_path(current_store.id, @order.id)
	  end

	  def customer_params
	  	params.permit(:name, :street_address, :city, :state, :zip_code, :phone_number, :email)
	  end

	  def guest_params
	  	params.permit(:name, :street_address, :city, :state, :zip_code, :phone_number, :email)
	  end

    def order_params
      params.permit(:order).permit(:customer, :price_in_cents, :completed, :date_paid, :charge_id, :guest)
    end


end
