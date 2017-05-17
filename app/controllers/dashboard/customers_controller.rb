class Dashboard::CustomersController < DashboardController

before_action :get_store
before_action :authenticate_owner!

def index
	@customers = @store.customers.all
end

# def show
# 	@customer = @store.customers.find(params[:id])
# end



	private

	def get_store
	  @store = Store.friendly.find(params[:store_id])
	end


end