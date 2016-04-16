class Product < ActiveRecord::Base

	belongs_to :owner
	has_many :order_lines


	validates :owner, presence: true
	validates :title, length: { minimum: 5}, presence: true
	validates :description, length: { minimum: 10}, presence: true
	validates :sku, presence: true, numericality: { only_integer: true }
	validates :price, presence: true, numericality: true
	validates :count, presence: true, numericality: { only_integer: true}

end
