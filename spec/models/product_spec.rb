require 'rails_helper'

describe Product do
  it 'has valid factories' do
    expect(build :product).to be_valid
  end

  it { is_expected.to validate_presence_of(:name) }

end
