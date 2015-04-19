class OrdersController < ApplicationController
  def new
    @order = Order.new
    @products = Product.all
  end
end
