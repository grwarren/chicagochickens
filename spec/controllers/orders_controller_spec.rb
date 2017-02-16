require 'rails_helper'

describe OrdersController, :type => :controller do

  let(:user) { create :user_with_orders }
  before(:each) do
    create :delivery_schedule, date: 1.week.from_now
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

  describe 'GET /next_order' do
    it 'shows next order page' do
      get :next_order
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:next_order)
    end
  end
end
