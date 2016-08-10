class Dashboard::ProductsController < DashboardController

  before_action :get_store

  def index
    @products = @store.products.all
  end

  def show
    @product = Product.friendly.find(params[:id])
  end

  def new
    @product = Product.new
    authorize @product
  end


  def create
    @product = Product.new
    @product = @store.products.build(product_params)

    authorize @product

    if @product.save
      flash[:notice] = "Product was added to store"
      redirect_to dashboard_store_products_path
    else
      flash[:error] = "There was an error saving the product."
      render :new
    end
  end


  def edit
    @product = Product.friendly.find(params[:id])
    authorize @product
  end


  def update
    @product = Product.friendly.find(params[:id])
    authorize @product
    
    @product.assign_attributes(product_params)

    if @product.save
      flash[:notice] = "Product was updated."
      redirect_to dashboard_store_products_path
    else
      flash[:error] = "There was an error saving the product. Please try again."
      render :edit
    end
  end

  def destroy
    @product = Product.friendly.find(params[:id])
    authorize @product

    if @product.destroy
      flash[:notice] = "\"#{@product.title}\" was deleted successfully."
      redirect_to dashboard_store_products_path and return
    else
      flash[:error] = "There was an error deleting the product."
    end

    respond_to do |format|
      format.html
      format.js
    end
  end


  private

  def product_params
    params.require(:product).permit(:title, :description, :sku, :price_in_cents, :count)
  end


  def get_store
   @store = Store.friendly.find(params[:store_id])
  end

end
