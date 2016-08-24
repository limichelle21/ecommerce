class Dashboard::StoresController < DashboardController


	def show
		@store = Store.friendly.find(params[:id])
	end

	def new
		@store = Store.new
	end

	def create
		@owner = current_user
		@store = @owner.stores.build(store_params)
		
		if @store.save
			flash[:notice] = "Store was created."
	  		redirect_to dashboard_store_products_path(@store.id)
	    else
	      flash[:error] = "There was an error creating the store."
	      render :new
	    end
  	end

		
 #  	def edit
 #  		@store = Store.friendly.find(params[:id])
 #  	end
	

	# def update
	# 	@store = Store.friendly.find(params[:id])
	# 	@store.assign_attributes(store_params)

	# 	if @store.save
	# 		flash[:notice] = "Store was updated."
	# 		redirect_to dashboard_store_products_path
	# 	else
	# 		flash[:error] = "There was an error updating the store. Please try again."
	# 		render :edit
	# 	end
	# end


  private

  def store_params
    params.require(:store).permit(:name, :owner_id)
  end

	

end