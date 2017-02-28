require 'rails_helper'

describe OrdersController, :type => :controller do

  let(:user) { create :user }
  let(:new_order) { build :order }
  before(:each) do
    create :delivery_schedule, date: 1.week.from_now
    session[:user_id] = user._id
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

    it 'should return index_all' do
      get :index_all

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index_all)
    end
  end

  describe 'GET /next_order' do
    it 'shows next order page' do
      get :next_order
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:next_order)
    end
  end

  describe 'POST /new' do
    it 'should save new order with items' do
      post :create, params: {user_name: user.name, order: new_order.attributes}
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /myorders' do
    it 'should retreive all future orders for a user' do
      get :myorders
      expect(response).to have_http_status(:success)
    end
  end
end
