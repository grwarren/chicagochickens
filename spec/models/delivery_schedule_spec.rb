require 'rails_helper'

describe DeliverySchedule do
  it 'has a valid factory' do
    expect(build :delivery_schedule).to be_valid
  end

  it { is_expected.to validate_presence_of :date }
end
