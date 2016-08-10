require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  let(:my_product) { create(:product) }
  let(:my_store) { create(:store) }


  context "customer" do 

    describe "GET show" do 
      it "returns http success" do
        get :show, store_id: my_store.id, id: my_product.id
        expect(response).to have_http_status(:success)
      end
    
      it "renders the #show view" do 
        get :show, store_id: my_store.id, product_id: my_product.id
        expect(response).to render_template :show
      end
    end

  end


  context "owner" do 

    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET show" do
      it "returns http success" do
        get :show
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do 
        get :show, product_id: my_product.id
        expect(response).to render_template :show
      end

      it "assigns my_product to @product" do 
        get :show, product_id: my_product.id 
        expect(assigns(:product)).to eq(my_product)
      end
    end

    describe "GET new" do
      it "returns http success" do
        get :new, product_id: my_product.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new, product_id: my_product.id
        expect(response).to render_template :new
      end

      # it "instantiates @product" do 
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit
        expect(response).to have_http_status(:success)
      end
    end

    describe "POST create" do
      it "returns http success" do
        post :create
        expect(response).to have_http_status(:success)
      end
    end

    describe "PUT update" do
      it "returns http success" do
        put :update
        expect(response).to have_http_status(:success)
      end
    end

    describe "DELETE destroy" do
      it "returns http success" do
        delete :destroy
        expect(response).to have_http_status(:success)
      end
    end

  end
end
