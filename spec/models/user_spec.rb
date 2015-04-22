require 'rails_helper'

describe User do
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
      user = create :user

      expect(user.to_param).to eql("#{user.user_id}")
    end
  end
end
