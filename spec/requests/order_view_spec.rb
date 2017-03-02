require 'rspec'
require 'rails_helper'

describe 'Order Views', :type => :request  do

  let(:order) { create :order }
  # TODO: create scenario adding user/orders from views
  
  let(:user) { create :user }

  before(:each) do
    create :delivery_schedule, date: 1.week.from_now
    order.save
    request.session[:user_id] = user._id
  end
  
  it 'should should render next order' do
    get '/nextOrder'
    expect(response).to have_http_status(:success)
  end
end