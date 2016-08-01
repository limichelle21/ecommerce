class WelcomeController < ApplicationController

	skip_before_action :current_store
	skip_before_action :current_order

	def index
	end

end