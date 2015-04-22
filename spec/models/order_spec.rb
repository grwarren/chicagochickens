require 'rails_helper'

describe Order, type: :model do

  it 'has valid factory' do
    expect(build :order).to be_valid
    expect(build :order_with_product).to be_valid
  end

  describe 'save' do
    let(:order) { build :order }
    let(:product) { create :product }

    it 'saves with product' do
      order.product = product
      expect { order.save }.to change(Order, :count).by(1)

      order.save
      expect(order.product).to eql product
    end
  end
end
