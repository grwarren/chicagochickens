class OrdersController < ApplicationController
  def new
    @order = Order.new
    @products = Product.all
    p @products.length
  end
end
