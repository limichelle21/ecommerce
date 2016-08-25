class Order < ActiveRecord::Base


	belongs_to :customer
	belongs_to :guest
	belongs_to :store
	has_many :order_lines

	validates :guest, presence: true, allow_nil: true
	validates :customer, presence: true, allow_nil: true



	
	def subtotal
		order_lines.collect { |ol| ol.present? ? ol.total_price : 0 }.sum
	end

	def total_items
		order_lines.sum(:quantity)
	end



end
