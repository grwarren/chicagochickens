require 'rails_helper'

describe Product do
  it 'has valid factories' do
    expect(build :product).to be_valid
  end

  it { is_expected.to validate_presence_of(:name) }

  it 'should sort by sort_order' do
     product1 = build :product
     product2  = build :product, sort_order: 2

     products = [product2, product1].sort()

     expect(products[0].sort_order).to eq(1)
     expect(products[1].sort_order).to eq(2)
   end

end