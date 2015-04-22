require 'rails_helper'

describe User, type: :model do
  it 'has valid factories' do
    expect(build :user).to be_valid
    expect(build :user_with_orders).to be_valid
  end
end
