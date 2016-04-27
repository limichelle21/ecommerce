class ProductPolicy < ApplicationPolicy 

	def initialize(owner)
		@owner = owner
	end

	def index?
		true
	end



	def new?
		create?
	end

	def create?
		is_owner? 
	end

	def edit?
		update?
	end

	def update?
		is_owner? 
	end

	def destroy?
		is_owner? 
	end




	private
	
	def is_owner?
		user.owner?
	end

end
