class Dashboard::ProductsController < DashboardController


  def index
    @products = Product.all
  end

  def show
    @product = Product.friendly.find(params[:id])
  end

  def new
    @product = Product.new
    authorize @product
  end


  def edit
    @product = Product.friendly.find(params[:id])
    authorize @product
  end


  def create
    @product = Product.new(product_params)
    authorize @product

    if @product.save
      flash[:notice] = "Product was added to store"
      redirect_to @product
    else
      flash[:error] = "There was an error saving the product."
      render :new
    end
  end



  def update
    @product = Product.friendly.find(params[:id])
    authorize @product
    
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
    @product = Product.friendly.find(params[:id])
    authorize @product

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


end
