require 'rails_helper'

describe Order do

  it 'has valid factories' do
    expect(build :order).to be_valid
  end

  it { is_expected.to belong_to(:user).of_type(User) }

  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:delivery_date) }
 

  describe 'save' do
    let(:order) { build :order }

    it 'saves with order items' do
      expect(order.order_items.size).to eql(2)

      expect { order.save }.to change(Order, :count).by(1)

      order.save

      saved_order =  Order.find(order.id)
      expect(saved_order.order_items.size).to eql(2)
    end
  end

end
