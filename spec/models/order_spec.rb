require 'rails_helper'

describe Order do

  it 'has valid factories' do
    expect(build :order).to be_valid
  end

  it { is_expected.to belong_to(:user).of_type(User) }

  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:product_name) }
  it { is_expected.to validate_presence_of(:quantity) }

  describe 'save' do
    let(:order) { build :order }

    it 'saves with product' do
      expect { order.save }.to change(Order, :count).by(1)

      order.save
    end
  end

end
