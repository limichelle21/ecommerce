class Dashboard::StoresController < DashboardController

	def new
	end

	def create
	end

	def show
		@store = Store.find(params[:id])
	end

	def update
	end
	

end