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
end
