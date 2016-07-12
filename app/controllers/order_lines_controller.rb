class OrderLinesController < ApplicationController

	def index
		@order = Order.find(params[:order_id])
		@order_lines = @order.order_lines.all
	end

	def show
		@order_line = OrderLine.find(params[:id])
	end

	# find @order by session ID - current_user.order?

	def new
		@order = Order.find(params[:order_id]) || Order.new
	    @order_line = @order.order_lines.new
	    authorize @order_line
	end

	def create
		@store = Store.friendly.find(params[:store_id])

		if session[:current_order_id].present?
			@order = Order.find_by(id: session[:current_order_id])
		else
			# need to associate a store with an order with an order line. Where does store come into play with current_user?

			# @store.current_user.orders.create? 
			
			@order = current_user.present? ? current_user.orders.create : @store.orders.create
			session[:current_order_id] = @order.id
		end

	    @order_line = @order.order_lines.build(order_line_params)
	    

	    if @order_line.save
	      flash[:notice] = "Product was added to Cart"
	      redirect_to :back
	    else
	      flash[:error] = "There was an error adding product to Cart."
	      redirect_to :back
	    end
	end

	def edit
		@order_line = OrderLine.find(params[:id])
	    authorize @order_line
	end

	def update
		@order = Order.find_by(id: session[:current_order_id])
		@order_line = OrderLine.find(params[:id])
	    authorize @order_line

	    @order_line.assign_attributes(order_line_params)

	    if @order_line.save
	      flash[:notice] = "Item was updated in the cart."
	      redirect_to [@order, @order_line]
	    else
	      flash[:error] = "Item was not updated in the cart. Please try again."
	      render :edit
	    end
	end

	def destroy
		@order_line = OrderLine.find(params[:id])
	    authorize @order_line

	    if @order_line.destroy
	      flash[:notice] = "Item was removed from cart successfully."
	      redirect_to @order
	    else
	      flash[:error] = "There was an error removing item from cart. Please try again."
	      render :show
	    end
	end

	private
  
	  def order_line_params
	    params.require(:order_line).permit(:product_id, :order_id, :quantity, :price, :price_in_cents)
	  end


end

