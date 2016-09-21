class OrdersController < ApplicationController
	layout 'customer'

	before_action :get_store, only: [:index, :show]

	def index
		# @orders = @store.orders.all
		customer = Customer.find(params[:current_customer_id)
		@orders = customer.orders.all 
	end

	def show
		@order = @store.orders.find(params[:id])
	end
	
	def confirmation
		@order = @store.orders.find(params[:id])
		@customer = @order.customer 
	end


 private
  
  # def order_params
  #    params.require(:order).permit(:customer, :total, :completed, :date_paid)
  # end

  def get_store
  	@store = Store.friendly.find(params[:store_id])
  end

  # need to scope based on customer (store, then customer)


end

