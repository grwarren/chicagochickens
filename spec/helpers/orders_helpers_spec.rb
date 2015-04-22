require 'spec_helper'
require 'action_view/helpers'


describe OrdersHelper do
  let(:product) { build :product }

  describe '#prularize_units' do
    it 'does not prularize single product counts' do
      One = 1
      expect(helper.prularize_units(One, product)).to eq "#{One} (Dozen)"
    end

    it 'does not prularizes multiple product counts' do
      Two = 2
      expect(helper.prularize_units(Two, product)).to eq "#{Two} (Dozens)"
    end

    it 'adds product name when product has no unit' do
      Two = 34
      product_with_not_units  = build(:product, name: 'Geese Eggs', unit: '')

      expect(helper.prularize_units(Two, product_with_not_units)).to eq "#{Two} #{product_with_not_units.name}"
    end
  end
end
