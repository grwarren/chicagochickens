require 'rails_helper'

describe OrdersController, :type => :controller do

  describe 'GET /new' do
    before(:each) do
      @products = create_list :product, 2
    end

    it 'shows new order page with new order and products' do
      get :new

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)

      expect(assigns :order).to be_a(Order)
      expect(assigns :products).to match_array(@products)
    end
  end

  describe 'POST /create' do
    let(:user) { create :user }
    let(:product) { create :product }
    describe 'valid params' do
      it 'saves new order' do
        expect {  post :create,  order: { quantity: 10, product: product.id } , user_id: user.user_id }.to change(Order, :count).by(1)
      end

      it 'saves order with ordered product' do
        post :create,  order: { quantity: 10, product: product.id } , user_id: user.user_id

        expect(assigns(:order).reload.product).to eql product
      end

      it 'redirects to new order page after save' do
        post :create,  order: { quantity: 10, product: product.id } , user_id: user.user_id

        expect(flash[:notice]).to eql("Your order has been recieved")
        expect(response).to redirect_to user_orders_path(user_id: user.user_id)
      end
    end

    describe 'invalid params' do
      it 'renders new with errors' do
        post :create,  order: { quantity: 10, product: '' } , user_id: user.user_id
        expected_errors = ["Product can't be blank"]

        expect(response).to render_template(:new)
        expect(assigns :order).to_not be_valid
        expect(assigns :products).to contain_exactly(product)
        expect(assigns(:order).errors.full_messages).to match_array(expected_errors)
      end
    end
  end
end
