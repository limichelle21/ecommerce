class ProductsController < ApplicationController

  # before_action :authorize_user, except: [:show]

  def index
    @store = Store.friendly.find(params[:store_id])
    @products = @store.products.all
  end

  def show
    @product = Product.friendly.find(params[:id])

  end



  # def authorize_user
  #   product = Product.find(params[:id])

  #   unless current_user == current_user.owner? || current_user.admin?
  #     flash[:alert] = "You must be authorized to do that."
  #     redirect_to product 
  #   end
end
