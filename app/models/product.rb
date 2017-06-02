class Product < ActiveRecord::Base

	extend FriendlyId
	friendly_id :title, use: :slugged

	mount_uploader :image, ImageUploader

	belongs_to :store
	has_many :order_lines


	validates :store, presence: true
	validates :title, length: { minimum: 5}, presence: true
	validates :description, length: { minimum: 10}, presence: true
	validates :sku, presence: true, numericality: { only_integer: true }
	validates :price, presence: true, numericality: { greater_than: 0 }
	validates :count, presence: true, numericality: { only_integer: true}

	# Add a boolean :active to indicate if product is live or not?

	def price # getter for rent in cents
		read_attribute(:price_in_cents)
	end

	def price=(v) # setter for rent in cents
		# v = v.to_s
		# v = v.gsub(',','')
		# v = v.gsub('$','')

		v.to_i if v.is_a?(String)

		write_attribute(:price_in_cents, v * 100)
	end

end
