require 'rails_helper'

RSpec.describe OrderLinesController, type: :controller do

  let(:my_order_line) { create(:order_line) }
  let(:my_order) { create(:order) }


  describe "POST create" do
    it "returns http success" do
      post :create, order_id: my_order.id, order_line: my_order_line.id
      expect(response).to have_http_status(:success)
    end
  end


  describe "PUT update" do
    it "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE destroy" do
    it "returns http success" do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end

end
