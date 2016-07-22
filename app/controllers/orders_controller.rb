class OrdersController < ApplicationController

	before_action :get_store, only: [:index, :show, :create]

	def index
		@orders = @store.orders.all
	end

	def show
		@order = Order.find(params[:id])
		
	end

	def new
		@order = Order.new
	end
	
	def create
		@order = Order.new
	end

	def edit
		@order = Order.find(params[:id])
		authorize @order
	end

	def update
		@order = Order.find(params[:id])
	    authorize @order

	    @order.assign_attributes(order_params)

	    if @order.save
	      flash[:notice] = "Order was saved successfully."
	      redirect to @order
	    else
	      flash[:error] = "The order was not updated. Please try again."
	      render :edit
	    end
	end

	def destroy
		@order = Order.find(params[:id])
	    authorize @order 
	    
	    if @order.destroy
	      flash[:notice] = "Order was deleted successfully."
	      redirect_to :index
	    else
	      flash[:error] = "There was an error deleting the order."
	      render :show
	    end
	end

 private
  
  def order_params
     params.require(:order).permit(:customer, :total, :completed, :date_paid)
  end

  def get_store
  	@store = Store.friendly.find(params[:store_id])
  end

end

