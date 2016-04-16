class OrderLine < ActiveRecord::Base

	belongs_to :product
	belongs_to :order

	validates :product, presence: true
	validates :order, presence: true
	validates :quantity, presence: true
	validates :price, presence: true, numericality: true

end
