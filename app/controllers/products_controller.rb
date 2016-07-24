class ProductsController < ApplicationController

  before_action :get_store


  def index
    @products = @store.products.all

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
