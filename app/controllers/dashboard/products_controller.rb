class Dashboard::ProductsController < DashboardController

  # before_action :authenticate_owner!, except: [:index, :new]
  before_action :get_store

  after_filter { flash.discard if request.xhr? }

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
    else
      flash[:error] = "There was an error deleting the product."
    end
    @products = @store.products.all

    if @product.delete
      flash[:notice] = "Product was deleted."
      redirect_to dashboard_store_products_path
    else
      flash[:error] = "There was an error deleting the product. Please try again."
      render :index
    end
  end


  private

  def product_params
    params.require(:product).permit(:title, :description, :sku, :price_in_cents, :count, :image, :remove_image)
  end


  def get_store
   @store = Store.friendly.find(params[:store_id])
  end

end
