require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe "POST #create" do
   let(:product) { build :product }

    it "redirects to all product path" do
      post :create, product: product.attributes

      expect(response).to redirect_to new_product_path
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
