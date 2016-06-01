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
      user = build :user
      expect(user.to_param).to eql("#{user.user_id}")
    end
  end

  describe 'to_product_map' do
    it 'returns product with map with two date keys' do
      user = build :user_with_orders
      build :delivery_schedule
      expect(user.to_product_map.size).to eq(1)
      expect(user.to_product_map["Chicken Eggs"].size).to eq(2)
    end
  end

end
