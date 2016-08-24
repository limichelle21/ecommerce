class Customer < User

	belongs_to :store
	has_many :orders

end