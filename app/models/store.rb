class Store < ActiveRecord::Base

	extend FriendlyId
	friendly_id :name, use: :slugged

	belongs_to :owner
	# class_name: 'User', foreign_key: 'user_id'
	has_many :products
	has_many :orders
	
	has_many :memberships, :dependent => :destroy
	has_many :customers, through: :memberships

	validates :owner, presence: true
	validates :name, presence: true, uniqueness: true
	validates_exclusion_of :name, in: %w[www ecommerce contactus faq terms]

end
