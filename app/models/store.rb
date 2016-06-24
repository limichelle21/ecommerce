class Store < ActiveRecord::Base

	extend FriendlyId
	friendly_id :name, use: :slugged

	belongs_to :owner
	has_many :products
	has_many :orders

	validates :owner, presence: true
	validates :name, presence: true, uniqueness: true
	validates_exclusion_of :name, in: %w[www ecommerce contactus faq terms]

end
