class OrdersController < ApplicationController
  def new
    @order = Order.new
    @products = Product.all
  end

   def index
     @orders = Order.all
   end
end
