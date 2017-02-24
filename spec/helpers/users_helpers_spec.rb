require 'spec_helper'
require 'action_view/helpers'

describe UsersHelper do
  let(:current_user) { build :user }

  describe '#user_orders_headers' do
    it 'shows generic header' do
      expect(helper.user_orders_headers(nil)).to eql('Orders')
    end

    it 'shows user specific header' do
      expect(helper.user_orders_headers(current_user)).to eql("Orders for #{current_user.name}")
    end
  end
end
