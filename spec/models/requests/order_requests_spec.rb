require 'rails_helper'

include Requests

describe Requests::OrderRequest do
  let(:product) { create :product }
  let(:user) { create :user }
  let(:valid_params) { {quantity: 10, product: "#{product.id}", user: user} }
  let(:invalid_params) { {product: "", quantity: 10, user: user} }

  describe '#valid?' do
    it 'is invalid if product is missing in params' do
      order_request = Requests::OrderRequest.new(params: invalid_params)
      expect(order_request.valid?).to be_falsey
    end

    it 'is invalid if product with given id does not exist' do
      NON_EXISTENT = 5050
      order_request = Requests::OrderRequest.new params: {quantity: 10, product: "#{NON_EXISTENT}", user: user}

      expect(order_request.valid?).to be_falsey
      expect(order_request.errors.full_messages).to match_array(["Product does not exist"])
    end

    it 'invalid if no user is given' do
      Empty = nil
      order_request = Requests::OrderRequest.new params: {quantity: 10, product: "#{product.id}", user: Empty}

      expect(order_request.valid?).to be_falsey
      expect(order_request.errors.full_messages).to match_array(["User is not known"])
    end

    it 'is valid if product, user and quantity keys are in params' do
      order_request = Requests::OrderRequest.new(params: valid_params)

      expect(order_request.valid?).to be_truthy
    end
  end


  describe '#save' do
    describe 'valid order request' do
      let(:order_request) { Requests::OrderRequest.new(params: valid_params) }

      it 'calls save on order' do
        expect_any_instance_of(Order).to receive(:save)

        order_request.save
      end

      it 'orders incearese by one' do
        expect { order_request.save }.to change(Order, :count).by(1)
      end
    end

    describe 'invalid order request' do
      let(:order_request) { Requests::OrderRequest.new(params: invalid_params) }

      it 'does not call save on order' do
        expect_any_instance_of(Order).to_not receive(:save)

        order_request.save
      end
    end
  end
end
