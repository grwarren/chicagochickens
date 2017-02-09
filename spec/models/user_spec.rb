require 'rails_helper'

describe User do
  before {pending("mongoid-rspec")}
  it 'has valid factories' do
    expect(build :user).to be_valid
    expect(build :user_with_orders).to be_valid
  end

  it { is_expected.to have_many(:orders).of_type(Order) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_uniqueness_of(:user_id) }


  describe 'to_param' do
    it 'returns user_id instead of mongo\'s Object._id' do
      user = build :user
      expect(user.to_param).to eql("#{user.user_id}")
    end
  end

  describe 'is_admin' do
    it 'returns false when user is not admin' do
      user = build :user
      expect(user.is_admin).to eq(false)
    end

    it 'returns true when user is admin' do
      user = build(:user, user_id: 1)
      expect(user.is_admin).to eq(true)
    end
  end

end
