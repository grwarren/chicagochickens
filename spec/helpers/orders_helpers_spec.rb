require 'rails_helper'
require 'action_view/helpers'

ZERO = 0
ONE = 1
TWO = 2

describe OrdersHelper do
  let(:product) { create :product, unit: 'Egg' }

  describe '#pluralize_units' do
    it 'does pluralize multiple product units' do
      expect(helper.pluralize_units(TWO, product.name)).to eq "#{TWO} Eggs"
    end

    it 'does not pluralize single product unit' do
      expect(helper.pluralize_units(ONE, product.name)).to eq "#{ONE} Egg"
    end

    it 'does pluralize zero product units' do
      expect(helper.pluralize_units(ZERO, product.name)).to eq "#{ZERO} Eggs"
    end

    it 'does not pluralize multiple special product unit' do
      product_with_special_unit = create(:product, unit: 'Dozen')
      expect(helper.pluralize_units(TWO, product_with_special_unit.name)).to eq "#{TWO} Dozen"
    end

    it 'adds product name when product has no unit' do
      product_with_no_units = create(:product, name: 'Geese Eggs', unit: '')

      expect(helper.pluralize_units(TWO, product_with_no_units.name)).to eq "#{TWO} #{product_with_no_units.name}"
    end
  end
end
