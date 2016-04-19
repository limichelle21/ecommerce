require 'rails_helper'

RSpec.describe Product, type: :model do
  
 	let(:product) { create(:product) }

 	it { should belong_to (:owner) }
 	it { should have_many (:order_lines) }

 	it { should validate_presence_of(:owner) }

 	it { should validate_presence_of(:title) }
 	it { should validate_length_of(:title).is_at_least(5) }

 	it { should validate_presence_of(:description) }
 	it { should validate_length_of(:description).is_at_least(10) }

 	it { should validate_presence_of(:sku) }
 	it { should validate_numericality_of(:sku).only_integer }

	it { should validate_presence_of(:price) }
	it { should validate_numericality_of(:price) }

	it { should validate_presence_of(:count) }
	it { should validate_numericality_of(:count).only_integer }

end
