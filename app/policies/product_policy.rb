class ProductPolicy < ApplicationPolicy 

	def index?
		true
	end

	def show?
		true
	end

	attr_reader :user, :product
	# why attr_reader, not attr_accessor? because there's no need to write/set variables? Policy to give read-only access

	def initialize(user, product)
		@user = user
		@product = product
	end

	#current_user is auto-passed through as user (Pundit)


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
		is_owner? && product.owner == user
	end

	def destroy?
		is_owner? && product.owner == user
	end


	private
	
	def is_owner?
		user.owner?
	end

end
