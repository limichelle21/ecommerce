class ProductsController < ApplicationController

  before_action :authorize_user, except: [:show]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new
    @product = products.build(product_params)
    @product.user = owner

    if @product.save
      flash[:notice] = "Product was added to store"
      redirect_to @product
    else
      flash[:error] = "There was an error saving the product."
      render :new
    end
  end

  def update
    @product = Product.find(params[:id])
    @product.assign_attributes(product_params)

    if @product.save
      flash[:notice] = "Product was updated."
      redirect_to @product
    else
      flash[:error] = "There was an error saving the product. Please try again."
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])

    if @product.destroy
      flash[:notice] = "\"#{product.title}\" was deleted successfully."
      redirect_to :index
    else
      flash[:error] = "There was an error deleting the product."
      render :show
    end
  end


  private

  def product_params
    params.require(:product).permit(:title, :description, :sku, :price, :count)
  end

  def authorize_user
    product = Product.find(params[:id])

    unless current_user == product.owner || current_user.admin?
      flash[:alert] = "You must be authorized to do that."
      redirect_to product 
    end
end
