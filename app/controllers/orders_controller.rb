class OrdersController < ApplicationController
 

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
