require 'spec_helper'
require 'action_view/helpers'


describe UsersHelper do
  let(:current_user) { build :user }

  describe '#build_user_path' do
    it 'sets users/:id/orders when user :current_user is set' do
      expect(helper.build_user_path(current_user)).to eql(user_orders_path(current_user.user_id))
    end

    it 'sets /orders when user :current_user is not set' do
      expect(helper.build_user_path(nil)).to eql(orders_path)
    end
end

  describe '#user_orders_headers' do
    it 'shows generic header' do
      expect(helper.user_orders_headers(nil)).to eql("Current Orders")
    end

    it 'shows user specific header' do
      expect(helper.user_orders_headers(current_user)).to eql("Current Orders for #{current_user.name}")
    end
  end
end
