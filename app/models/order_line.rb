class OrderLine < ActiveRecord::Base

	belongs_to :product
	belongs_to :order

	validates :product, presence: true
	validates :order, presence: true
	validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
	validates :price_in_cents, presence: true, numericality: true



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

	
	# before_save :finalize

	def unit_price
		product.price_in_cents
	end

	def total_price
		unit_price * quantity
	end

	# private

	# def finalize
	# 	self[:unit_price] = unit_price
	# 	self[:total_price] = quantity * self[:unit_price]
	# end



end
