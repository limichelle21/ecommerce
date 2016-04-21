class Product < ActiveRecord::Base

	belongs_to :owner
	has_many :order_lines


	validates :owner, presence: true
	validates :title, length: { minimum: 5}, presence: true
	validates :description, length: { minimum: 10}, presence: true
	validates :sku, presence: true, numericality: { only_integer: true }
	validates :price, presence: true, numericality: true
	validates :count, presence: true, numericality: { only_integer: true}

	def price # getter for rent in cents
		read_attribute(:price_in_cents) / 100.0
	end

	def price=(v) # setter for rent in cents
		# v = v.to_s
		# v = v.gsub(',','')
		# v = v.gsub('$','')

		v.to_i if v.is_a?(String)

		write_attribute(:price_in_cents, v * 100)
	end

end
