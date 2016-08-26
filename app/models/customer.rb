class Customer < User

	has_many :memberships, :dependent => :destroy
	has_many :stores, through: :memberships
	has_many :orders

end