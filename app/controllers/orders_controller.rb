class OrdersController < ApplicationController
  before_action :current_user
  before_action :set_products, only: [:new, :create, :index, :myorders]

  # GET /users/1/orders/edit?deliveryDate=2017-03-10
  def edit
    @orders = @current_user.orders.where(delivery_date: params[:deliveryDate])
    build_grid(@orders)
  end

  # GET /users/1/orders/new
  def new
    @orders = Responses::OrderResponse.new(user: @current_user).orders
    build_grid(@orders)
  end

  # GET /orders
  def index_all
    @orders = Order.all.order_by(:delivery_date.desc, :product.asc)
    build_grid(@orders)
  end

  # GET /myorders
  def myorders
    next_delivery_date = DeliverySchedule.where(:date.gte => Date.today).order_by(:date.asc).limit(1)
    logger.debug("Order for next date: #{next_delivery_date.first.date}")
    unless next_delivery_date.first.nil?
      @orders = @current_user.orders.where(delivery_date: next_delivery_date.first.date)
    end
  end

  # GET /nextOrder
  def next_order
    future_delivery_dates = DeliverySchedule.where(:date.gte => Date.today)
    unless future_delivery_dates.first.nil?
      next_delivery_date = future_delivery_dates.first.date
      @orders = Order.and({delivery_date: next_delivery_date}, {quantity: {'$gt' => 0}}).order_by(:product.asc, :user.asc)
      build_grid(@orders)
    end
  end

  def index
    logger.debug "ORDERS CONTROLLER: #{@current_user}"
    unless @current_user.nil?
      @orders = @current_user.orders.order_by(:delivery_date.desc, :product.asc)
      build_grid(@orders)
    end

  end

  def update
    if @current_user.update(user_params)
      redirect_to user_orders_url(@current_user), notice: "Your orders were successfully updated."
    else
      render :edit
    end
  end

  private
  def build_grid(orders)
    @grid = PivotTable::Grid.new do |g|
      g.source_data = orders.to_a
      g.column_name = :delivery_date
      g.row_name = :product_name
      g.value_name = :quantity
    end

    @grid.build
  end

  def user_params
    params.require(:user).permit!
  end

  def order_params
    params.require(:order).permit(:quantity, :delivery_date, :product_name, :user_name)
  end

  def set_products
    @products = Product.all.order_by(:sort_order.asc)
  end

end
