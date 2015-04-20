require 'rails_helper'

describe OrdersController, :type => :controller do

  describe 'GET /new' do
    before(:each) do
      @products = create_list :product, 2
    end

    it 'should show new order page' do
      get :new

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)

      expect(assigns :order).to be_a(Order)
      expect(assigns :products).to match_array(@products)
    end
  end

  describe 'POST /create' do
    let(:order) { build :order }

    it 'should show new order page' do
      post :create,  order: order.attributes

      expect(flash[:notice]).to eql("Your order has been recieved")
      expect(response).to redirect_to new_order_path
    end
  end

end
