class OrdersController < ApplicationController
  before_action :set_current_user
  before_action :set_products, :set_delivery_date, only: [:new, :create]

  def new
    @order = Order.new

  end

   def index
     @orders = Order.all
   end

  def create
    @order = Order.new(order_params.merge(user: @current_user))
    product_id = params[:order][:product]
    unless product_id.empty?
      product = Product.find_by(id: product_id)
      @order.product = product

      if @order.save
        redirect_to user_orders_path(user_id: @current_user.user_id) , notice: 'Your order has been recieved'
      else
        render :new
      end
    else
      render :new
    end
  end

private
  def order_params
    params.require(:order).permit(:quantity, :delivery_date)
  end

  def set_products
    @products = Product.all
  end

  def set_delivery_date
    @next_delivery_date = 1.week.from_now.strftime("%m-%d-%Y")
  end
end
