require 'spec_helper'
require 'action_view/helpers'

Two =  2
One = 1

describe OrdersHelper do
  let(:product) { build :product }

  describe '#prularize_units' do
    it 'does not prularize single product counts' do
      expect(helper.prularize_units(One, product)).to eq "#{One} (Dozen)"
    end

    it 'does not prularizes multiple product counts' do
      expect(helper.prularize_units(Two, product)).to eq "#{Two} (Dozens)"
    end

    it 'adds product name when product has no unit' do
      product_with_not_units  = build(:product, name: 'Geese Eggs', unit: '')

      expect(helper.prularize_units(Two, product_with_not_units)).to eq "#{Two} #{product_with_not_units.name}"
    end
  end
end
