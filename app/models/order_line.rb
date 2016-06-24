class OrderLine < ActiveRecord::Base

	belongs_to :product
	belongs_to :order

	validates :product, presence: true
	validates :order, presence: true
	validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
	validates :price, presence: true, numericality: true

	before_save :finalize

	def unit_price
		if persisted?
			self.[:unit_price]
		else
			product.price
		end
	end

	def total_price
		unit_price * quantity
	end

	private

	def finalize
		self[:unit_price] = unit_price
		self[:total_price] = quantity * self[:unit_price]
	end



end
