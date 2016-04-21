require 'rails_helper'


RSpec.describe Order, type: :model do

	let(:order) { create(:order) }
	it { should have_many (:order_lines) }
	it { should belong_to (:customer) }

	it { should validate_presence_of(:customer) }
	it { should validate_numericality_of(:total) }
	it { should allow_value(nil).for(:completed) } 
	it { should validate_presence_of(:date_paid) }


end
