require 'spec_helper'
include Responses

describe  Responses::OrderResponse do
  let(:user) { create :user}
  let(:order_response) { Responses::OrderResponse.new(user: user)}

  describe '#orders' do
    it 'is empty when no user is given' do
      expect(Responses::OrderResponse.new(user: nil).orders).to be_empty
    end

    it 'created for each product if user has not made any orders' do
      create :product
      p order_response.valid?
      expect(order_response.orders.size).to eq 1
    end
  end
end
