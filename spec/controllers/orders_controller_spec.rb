require 'rails_helper'

describe OrdersController, :type => :controller do

  before(:each) do
    @product = Product.create(name: 'Eggs', unit: 'Dozen')
  end

  it 'should show new order page' do
    get :new

    expect(response).to render_template(:new)
    expect(assigns :order).to be_a(Order)
    expect(assigns :products).to contain_exactly(@product)
  end
end
