class OrdersController < ApplicationController
  before_action :set_current_user
  before_action :set_products, :set_delivery_date, only: [:new, :create]

  def new
    @orders = Responses::OrderResponse.new(user: @current_user).orders
  end

   def index
     @orders = Order.all
   end

   def create
     params = order_params.merge(user: @current_user, delivery: @next_delivery_date)
     order_request = Requests::OrderRequest.new(params: params)
     if order_request.save
       redirect_to user_orders_path(@current_user) , notice: 'Your order has been recieved'
     else
       @order = order_request.order
       render :new
     end
   end

private
  def order_params
    params.require(:order).permit(:quantity, :delivery_date, :product)
  end

  def set_products
    @products = Product.all
  end

  def set_delivery_date
    @next_delivery_date = 1.week.from_now
  end
end
