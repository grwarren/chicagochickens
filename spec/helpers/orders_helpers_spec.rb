require 'spec_helper'
require 'action_view/helpers'

ONE = 1
TWO =  2

describe OrdersHelper do
  let(:product) { build :product }

  describe '#pluralize_units' do
    it 'does not pluralize single product counts' do
      expect(helper.pluralize_units(ONE, product)).to eq "#{ONE} Dozen"
    end

    it 'does not pluralizes multiple product counts' do
      expect(helper.pluralize_units(TWO, product)).to eq "#{TWO} Dozens"
    end

    it 'adds product name when product has no unit' do
      product_with_no_units  = build(:product, name: 'Geese Eggs', unit: '')

      expect(helper.pluralize_units(TWO, product_with_no_units)).to eq "#{TWO} #{product_with_no_units.name}"
    end
  end
end
