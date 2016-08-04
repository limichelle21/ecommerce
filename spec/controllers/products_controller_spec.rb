require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  let(:my_product) { create(:product) }
  let(:my_user) { create(:user) }


  context "customer" do 

    describe "GET show" do 
      it "returns http success" do
        get :show
        expect(response).to have_http_status(:success)
      end
    
      it "renders the #show view" do 
        get :show, product_id: my_product.id
        expect(response).to render_template :show
      end
    end

    describe "GET new" do 
      it "returns http redirect" do 
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "POST create" do 
      it "returns http redirect" do 
        post :create, product: { title: RandomData.random_sentence, body: RandomData.random_paragraph}
      end
    end
    
  end


  context "owner" do 

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #show" do
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

    describe "GET #new" do
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

    describe "GET #create" do
      it "returns http success" do
        get :create
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #update" do
      it "returns http success" do
        get :update
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #destroy" do
      it "returns http success" do
        get :destroy
        expect(response).to have_http_status(:success)
      end
    end

  end
end
