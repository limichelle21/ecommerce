class CartsController < ApplicationController
 
 before_filter :current_order

  def show
  	@order_lines = @current_order.order_lines
  end

end
