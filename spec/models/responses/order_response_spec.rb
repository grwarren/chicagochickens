require 'spec_helper'
include Responses

describe  Responses::OrderResponse do
  let(:user) { create :user}
  let(:order_response) { Responses::OrderResponse.new(user: user)}

  it { is_expected.to validate_presence_of :user }

  describe '#orders' do
    it 'is empty when no user is given' do
      expect(Responses::OrderResponse.new(user: nil).orders).to be_empty
    end

    it 'created for each product if user has not made any orders' do
      create_list :product, 2
      expect(order_response.orders.size).to eq 2
    end

    it 'merges existing orders and new orders for the user' do
      products = create_list :product, 2
      dove_eggs = create(:product, name: "Dove Eggs", unit: "Eggs")
      order = create(:order, user: user, product: dove_eggs)

      expect(order_response.orders.size).to eq 3
      expect(order_response.orders.map(&:product)).to include(dove_eggs)
    end
  end
end
