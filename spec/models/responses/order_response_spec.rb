require 'rails_helper'
include Responses

describe Responses::OrderResponse do
  let(:user) { create :user }
  let(:delivery_schedule) {create :delivery_schedule}
  let(:order_response) { Responses::OrderResponse.new(user_name: user.name, delivery_date: delivery_schedule.date) }

  describe '#orders' do
    it 'is empty when no user name is given' do
      expect(Responses::OrderResponse.new(user_name: nil).order).to be_nil
    end

    it 'should create new order with item for each product' do
      create_list :product, 2
      expect(order_response.order.order_items.size).to eq 2
    end

    it 'created for each product and delivery schedule if user has not made any orders' do
      create(:delivery_schedule, date: 2.weeks.from_now)
      create_list :product, 2
      expect(order_response.order.order_items.size).to eq 2
    end

    it 'merges existing orders and new orders for the user' do
      products = create_list :product, 2
      order = create(:order, user_name: user.name)
      create(:order_item, order: order, product_name: "Dove Eggs")

      expect(order_response.order.order_items.size).to eq 3
      expect(order_response.order.order_items.map(&:product_name)).to include("Dove Eggs")
    end
  end
end
