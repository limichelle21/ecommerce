class Order < ActiveRecord::Base


	belongs_to :customer
	belongs_to :store
	has_many :order_lines

	# validates :customer, presence: true
	# validates :store, presence: true
	# validates :price_in_cents, presence: true, numericality: true 
	# validates :completed, :inclusion => {:in => [true, false]} 
	# validates :date_paid, presence: true

	def order_price
	end

	# need a sum of order_line.total_price

end
