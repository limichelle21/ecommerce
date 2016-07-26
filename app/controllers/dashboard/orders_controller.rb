class Dashboard::OrdersController < DashboardController

#order belongs to a store
	before_action :get_store, only: [:index, :show]

	def index
		@orders = @store.orders.all
	end

	def show
		@order = @store.orders.find(params[:id])
	end


	def destroy
		@order = @store.orders.find(params[:id])
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