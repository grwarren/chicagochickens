require 'rails_helper'
require 'action_view/helpers'

describe SessionsHelper do
  let(:user) { build :user }

  describe '#log_in' do
    it 'does pluralize multiple product units' do
      expect(helper.log_in(user)).not_to be_nil
    end
  end

  describe '#is_admin'do
    it 'should return false for non admin user' do
      expect(helper.is_admin?).to be_falsey
    end

    it 'should return true for admin user' do
      adminUser = build :user, user_id: 1
      helper.log_in(adminUser)
      expect(helper.is_admin?).to be_truthy
    end
  end
end
