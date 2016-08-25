class Guest < ActiveRecord::Base

	has_one :order
	
end
