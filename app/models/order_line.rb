class OrderLine < ActiveRecord::Base

	belongs_to :product
	belongs_to :order


	validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
	
	validate :product_present
	validate :order_present





	def price # getter for price in cents
		read_attribute(:price_in_cents) / 100.0
	end

	def price=(v) # setter for price in cents
		# v = v.to_s
		# v = v.gsub(',','')
		# v = v.gsub('$','')

		v.to_i if v.is_a?(String)

		write_attribute(:price_in_cents, v * 100)
	end

	

	def unit_price
		product.price_in_cents
	end


	def total_price
		unit_price * quantity
	end

	# which record is actually doing the multiplication?

	private

		def product_present
			if product.nil?
				errors.add(:product, "is not valid or is not active.")
			end
		end

		def order_present
			if order.nil?
				errors.add(:order, "is not a valid order.")
			end
		end



end
