class Dashboard::StoresController < DashboardController

	def index
		@stores = Store.all
	end

	def show
		@store = Store.friendly.find(params[:id])
	end

	def new
		@store = Store.new
	end


	def create
		@store = Store.new
		@owner = current_user

		# need to extend the Devise controller? 
		
		raise current_user.inspect #nil 
		@store = @owner.store.build(store_params)

		# undefined method "stores" for Owner. When User is signed in, why @owner returns nil?
		
		if @store.save
			flash[:notice] = "Store was created."
	  		redirect_to @store
	    else
	      flash[:error] = "There was an error creating the store."
	      render :new
	    end
  	end

		
  	def edit
  		@store = Store.friendly.find(params[:id])
  	end
	

	def update
		@store = Store.friendly.find(params[:id])
		@store.assign_attributes(store_params)

		if @store.save
			flash[:notice] = "Store was updated."
			redirect_to @store
		else
			flash[:error] = "There was an error updating the store. Please try again."
			render :edit
		end
	end


  private

  def store_params
    params.require(:store).permit(:name, :owner_id)
  end

	

end