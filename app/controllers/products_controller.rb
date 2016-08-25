 class ProductsController < ApplicationController
  layout 'customer'

  skip_before_action :current_order
  before_action :get_store


  def index
    @products = @store.products.all
    @order_line = current_order.order_lines.new
  end

  # create a new instance of OrderLine model to use in forms

  def show
    @product = @store.products.friendly.find(params[:id])

  end


private

  def get_store
    @store = Store.friendly.find(params[:store_id])
  end


end
