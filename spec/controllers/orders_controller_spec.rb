require 'rails_helper'

describe OrdersController, :type => :controller do
  let(:user) { create :user }
  before(:each) do
    create :delivery_schedule
  end

  describe 'GET /new' do
    let(:products) { create_list :product, 2 }

    it 'shows new order page with new order and products' do
      get :new, params: { user_id: user.user_id }

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)

      expect(assigns :orders).to_not be_nil
      expect(assigns :products).to match_array(products)
    end
  end

  describe 'POST /create' do
    let(:product) { create :product }
    let(:valid_params) { { order: { quantity: 10, product_name: product.name, user_name: 'Marques Marcello' }, user_id: user.user_id } }

    describe 'valid params' do
      it 'saves new order' do
        expect { post :create, params: valid_params }.to change(Order, :count).by(1)
      end

      it 'saves order with ordered product' do
        expect_any_instance_of(Requests::OrderRequest).to receive(:save).and_return(true)

        post :create, params: valid_params
      end

      it 'redirects to new order page after save' do
        post :create, params: valid_params

        expect(flash[:notice]).to eql("Your order has been saved")
        expect(response).to redirect_to user_orders_path(user)
      end
    end

    describe 'invalid params' do
      let(:invalid_params) { { order: { quantity: 10, user_name: 'Marques Marcello', product_name: '' }, user_id: user.user_id } }

      it 'renders new with errors when product is missing' do
        expected_errors = ["Product Name can't be blank"]

        post :create, params: invalid_params

        expect(response).to render_template(:new)
        expect(assigns :order).to_not be_valid
        expect(assigns :products).to contain_exactly(product)
        expect(assigns(:order).errors.full_messages).to match_array(expected_errors)
      end

      it 'renders new with errors when user is missing' do
        expected_errors = ["User can't be blank", "User name can't be blank"]
        post :create, params: { order: { quantity: 10, user_name: 'Marques Marcello', product_name: product.name } }

        expect(response).to render_template(:new)
        expect(assigns :order).to_not be_valid
        expect(assigns :products).to contain_exactly(product)
        expect(assigns(:order).errors.full_messages).to match_array(expected_errors)
      end
    end
  end
end
