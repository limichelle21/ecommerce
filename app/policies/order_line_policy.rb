class OrderLinePolicy < ApplicationPolicy 

	def index?
		true
	end

	def show?
		true
	end

	attr_reader :user, :order_line
	# why attr_reader, not attr_accessor? because there's no need to write/set variables? Policy to give read-only access

	def initialize(user, order_line)
		@user = user
		@order_line = order_line
	end

	#current_user is auto-passed through as user (Pundit)


	def new?
		create?
	end

	def create?
		is_customer? 
	end

	def edit?
		update?
	end

	def update?
		is_customer? && order_line.order.customer == user || is_owner?
	end

	def destroy?
		is_customer? && order_line.order.customer == user || is_owner?
	end


	private
	
		def is_customer?
			user.customer?
		end

		def is_owner?
			user.owner?
		end

end