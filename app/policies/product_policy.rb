class ProductPolicy < ApplicationPolicy 

	def index?
		true
	end

	def show?
		true
	end

	attr_reader :owner, :product
	# why attr_reader, not attr_accessor? because there's no need to write/set variables?

	def initialize(owner, product)
		@owner = owner
		@product = product
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
