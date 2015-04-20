class OrdersController < ApplicationController
  def new
    @order = Order.new
    @next_delivery_date = 1.week.from_now.strftime("%m-%d-%Y")
    @products = Product.all
  end

   def index
     @orders = Order.all
   end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to new_order_path, notice: 'Your order has been recieved'
    else
      render new_order_path
    end
  end

private
  def order_params
    params.require(:order).permit(:quantity)
  end
end
