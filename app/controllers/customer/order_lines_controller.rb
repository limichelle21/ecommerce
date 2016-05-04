class Customer::OrderLinesController < CustomerController

  def show
    @order_line = OrderLine.find(params[:id])
  end

  def new
    @order_line = OrderLine.new
    authorize @order_line
  end

  def create
    @order_line = OrderLine.new(order_line_params)
    authorize @order_line

      if @order_line.save
        flash[:notice] = "Item was added to cart."
      else
        flash[:error] = "Item was not added to cart. Please try again."
        render :new
      end
  end


  def edit
    @order_line = OrderLine.find(params[:id])
    authorize @order_line
  end


  def update
    @order_line = OrderLine.find(params[:id])
    authorize @order_line

    @order_line.assign_attributes(order_line_params)
    if @order_line.save
      flash[:notice] = "Item was updated in the cart."
      redirect_to [@order, @order_line]
    else
      flash[:error] = "Item was not updated in the cart. Please try again."
      render :edit
    end
  end


  def destroy
    @order_line = OrderLine.find(params[:id])
    authorize @order_line

    if @order_line.destroy
      flash[:notice] = "Item was removed from cart successfully."
      redirect_to @order
    else
      flash[:error] = "There was an error removing item from cart. Please try again."
      render :show
    end
  end


  private
  
  def order_line_params
    params.require(:order_line).permit(:product, :order, :quantity, :price)
  end


end