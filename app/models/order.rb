class Order < ActiveRecord::Base


	belongs_to :customer
	has_many :order_lines

	validates :customer, presence: true
	validates :total, presence: true, numericality: true 
	validates :completed, :inclusion => {:in => [true, false]} 
	validates :date_paid, presence: true


end
