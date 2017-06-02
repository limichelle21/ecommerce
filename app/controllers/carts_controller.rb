class CartsController < ApplicationController
    
layout 'customer'


  def show
  	@order_lines = current_order.order_lines
  end

  def clear_cart
  	session["current_order_id_#{current_store.id}"] = nil
  	redirect_to store_path
  end


end
