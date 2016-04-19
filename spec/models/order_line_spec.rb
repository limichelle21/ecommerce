require 'rails_helper'

RSpec.describe OrderLine, type: :model do

	let(:order_line) { create(:order_line) }

	it { should belong_to(:order) }
	it { should belong_to(:product) }

	it { should validate_presence_of(:product) }
	it { should validate_presence_of(:order) }
	it { should validate_presence_of(:quantity) } 
	it { should validate_presence_of(:price) }
	it { should validate_numericality_of(:price) }


end
