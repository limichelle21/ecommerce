class Order < ActiveRecord::Base


	belongs_to :customer
	belongs_to :store
	has_many :order_lines


	
	def subtotal
		order_lines.collect { |ol| ol.present? ? ol.total_price : 0 }.sum
	end

	def total_items
		order_lines.sum(:quantity)
	end



end
