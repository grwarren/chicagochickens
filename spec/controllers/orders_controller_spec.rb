require 'rails_helper'

describe OrdersController, :type => :controller do
  let(:expected_delivery_date) { 1.week.from_now.strftime("%m-%d-%Y") }

  describe 'GET /new' do
    let(:products) { create_list :product, 2 }

    it 'shows new order page with new order and products' do
      get :new

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)

      expect(assigns :order).to be_a(Order)
      expect(assigns :next_delivery_date).to eql(expected_delivery_date)
      expect(assigns :products).to match_array(products)
    end
  end

  describe 'POST /create' do
    let(:user) { create :user }
    let(:product) { create :product }
    let(:valid_params) { { order: { quantity: 10, product: product.id } , user_id: user.user_id } }

    describe 'valid params' do
      it 'saves new order' do
        expect {  post :create,  valid_params }.to change(Order, :count).by(1)
      end

      it 'saves order with ordered product' do
        post :create,  valid_params

        expect(assigns(:order).reload.product).to eql product
      end

      it 'redirects to new order page after save' do
        post :create,  valid_params

        expect(flash[:notice]).to eql("Your order has been recieved")
        expect(response).to redirect_to user_orders_path(user)
      end
    end

    describe 'invalid params' do
      let(:invalid_params) { { order: { quantity: 10, product: '' }, user_id: user.user_id } }

      it 'renders new with errors when product is missing' do
        expected_errors = ["Product can't be blank"]

        post :create,  invalid_params

        expect(response).to render_template(:new)
        expect(assigns :order).to_not be_valid
        expect(assigns :products).to contain_exactly(product)
        expect(assigns :next_delivery_date).to eql(expected_delivery_date)
        expect(assigns(:order).errors.full_messages).to match_array(expected_errors)
      end

      it 'renders new with errors when user is missing' do
        expected_errors = ["User can't be blank"]
        post :create,  order: { quantity: 10, product: product.id }

        expect(response).to render_template(:new)
        expect(assigns :order).to_not be_valid
        expect(assigns :products).to contain_exactly(product)
        expect(assigns :next_delivery_date).to eql(expected_delivery_date)
        expect(assigns(:order).errors.full_messages).to match_array(expected_errors)
      end
    end
  end
end
