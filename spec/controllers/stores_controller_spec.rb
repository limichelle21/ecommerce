require 'rails_helper'


RSpec.describe StoresController, type: :controller do

	let(:my_store) { Store.create!(name: "Shop", owner: user ) }

	describe "GET show" do
		it "returns http success" do 
			get :show, store_id: my_store.store_id
			expect(response).to have_http_status(:success)
		end
	end

end
