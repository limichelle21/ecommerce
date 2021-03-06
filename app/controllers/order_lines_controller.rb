class OrderLinesController < ApplicationController

	layout 'customer'
	before_action :get_store, only: [:create, :update, :destroy]

    
	after_filter { flash.discard if request.xhr? }

	def create

		# if session[:current_order_id].present?
		# 	@order = Order.find_by(id: session[:current_order_id])
		# else
		# 	@order = current_user.present? ? current_user.orders.create : @store.orders.create
		# 	session[:current_order_id] = @order.id
		# end
		
		#check if product.id already exists in an order_line

		@order_line = current_order.order_lines.where(product_id: params[:order_line][:product_id]).first

		if @order_line.present? 
			@order_line.quantity += params[:order_line][:quantity].to_i
		else
			@order_line = current_order.order_lines.build(order_line_params)
		end			

	    if @order_line.save
	      session["current_order_id_#{current_store.id}"] = @order_line.order.id 
	      flash[:notice] = "Product was added to Cart"
	      redirect_to store_products_path
	    else
	      flash[:error] = "There was an error adding product to Cart."
	      redirect_to :back
	    end

	end


	def update
		@order_line = current_order.order_lines.find(params[:id])
	    @order_line.quantity = params[:order_line][:quantity].to_i
	 
	    if @order_line.save
	      flash[:notice] = "Item was updated in the cart."
	    else
	      flash[:error] = "Item was not updated in the cart. Please try again."
	    end

	    @order_lines = current_store.order_lines

	    respond_to do |format|
	      format.html
	      format.js
	    end

	end

	def destroy
		@order_line = current_order.order_lines.find(params[:id])

	    if @order_line.destroy
	      flash[:notice] = "Item was removed from cart successfully."
	    
	    else
	      flash[:error] = "There was an error removing item from cart. Please try again."
	    end

	   	@order_lines = current_order.order_lines

	    respond_to do |format|
	      format.html
	      format.js
	    end

	end

	private
  
	  def order_line_params
	    params.require(:order_line).permit(:product_id, :order_id, :quantity, :price, :price_in_cents)
	  end

	  def get_store
	  	@store = Store.friendly.find(params[:store_id])
	  end


end

