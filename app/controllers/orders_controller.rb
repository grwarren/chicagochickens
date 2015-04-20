class OrdersController < ApplicationController
  before_action :set_current_user

  def new
    @order = Order.new
    @next_delivery_date = 1.week.from_now.strftime("%m-%d-%Y")
    @products = Product.all
  end

   def index
     @orders = Order.all
   end

  def create
    product = Product.find_by(id: params[:order][:product])
    @order = Order.new(order_params.merge(user: @current_user, products: [product]))
    
    if @order.save
      redirect_to user_orders_path(user_id: @current_user.user_id) , notice: 'Your order has been recieved'
    else
      render redirect_to user_orders_path(user_id: @current_user.user_id)
    end
  end

private
  def order_params
    params.require(:order).permit(:quantity, :delivery_date)
  end
end
