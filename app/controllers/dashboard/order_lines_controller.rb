class Dashboard::OrderLinesController < DashboardController

    before_action :authenticate_owner!
	before_action :get_store, only: [:index, :show]

	def index
		@order = @store.orders.find(params[:order_id])
		@order_lines = @order.order_lines.all 
	end

	def show
		@order = @store.orders.find(params[:order_id])
		@order_line = @store.orders.find(params[:id])
	end

	
	private
  
	  def order_line_params
	    params.require(:order_line).permit(:product, :order, :quantity, :price)
	  end

	  def get_store
	  	@store = Store.friendly.find(params[:store_id])
	  end

end