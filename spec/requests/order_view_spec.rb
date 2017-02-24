require 'rspec'
require 'rails_helper'

describe 'Order Views', :type => :request  do

  let(:order) { create :order }
  # TODO: create scenario adding user/orders from views
  
  before(:each) do
    create :delivery_schedule, date: 1.week.from_now
    order.save
  end
  
  it 'should should render next order' do
    get '/nextOrder'
    expect(response).to have_http_status(:success)
  end
end