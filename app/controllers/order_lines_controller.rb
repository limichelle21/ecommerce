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
	    @order_line = OrderLine.new
	    authorize @order_line
	end

	def create
		if session[:current_order_id].present?
			@order = Order.find_by(id: session[:current_order_id])
		else
			# also need a check if current_user.customer? 
			@order = current_user.present? ? current_user.orders.create : Order.new
			session[:current_order_id] = @order.id
		end
	    @order_line = @order.order_lines.build(order_line_params)
	    authorize @order_line

	    if @order_line.save
	      flash[:notice] = "Product was added to Cart"
	      redirect_to @order
	    else
	      flash[:error] = "There was an error adding product to Cart."
	      render :new
	    end
	end

	def edit
		@order_line = OrderLine.find(params[:id])
	    authorize @order_line
	end

	def update
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
	    params.require(:order_line).permit(:product, :order, :quantity, :price)
	  end


end

