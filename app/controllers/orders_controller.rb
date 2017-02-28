class OrdersController < ApplicationController
  before_action :current_user
  before_action :set_products, only: [:new, :create, :index, :myorders]

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to orders_url(@current_user), notice: 'Your orders were successfully updated.'
    else
      render :new
    end
  end

  # GET /orders/58afba6ed22b1d66bc7d9f1f/edit
  def edit
    @order = Order.find(params[:id])
  end

  # GET orders/new?deliveryDate=2017-03-10
  def new
    @order = Responses::OrderResponse.new(user_name: @current_user.name, delivery_date: params[:deliveryDate]).order
  end

  # GET /orders
  def index_all
    @orders = Order.all.order_by(:delivery_date.desc, :product.asc)
    build_grid(@orders)
  end

  # GET /myorders
  def myorders
    @orders_map = {}

    future_delivery_dates = DeliverySchedule.where(:date.gte => Date.today).order_by(:date.asc)
    future_delivery_dates.each do | delivery |
      order = Order.and({user_name: @current_user.name, delivery_date: delivery.date})
      if order.length == 0
        @orders_map[delivery.date] = nil
      else
        @orders_map[delivery.date] = order.first
      end
    end

    @orders = Order.and({user_name: @current_user.name, :delivery_date.gte => Date.today}).order_by(:delivery_date.asc)
    logger.debug("Found #{@orders.count} existing orders")
  end

  # GET /nextOrder
  def next_order
    future_delivery_dates = DeliverySchedule.where(:date.gte => Date.today)
    unless future_delivery_dates.first.nil?
      next_delivery_date = future_delivery_dates.first.date
      @orders = Order.and({user_name: @current_user.name, delivery_date: next_delivery_date}).order_by(:product.asc, :user.asc)
      build_grid(@orders)
    end
  end

  def index
    unless @current_user.nil?
      @orders = Order.order_by(:delivery_date.desc, :product.asc)
      build_grid(@orders)
    end

  end

  def update
    params = order_params.merge(user: @current_user)
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to orders_url(@current_user), notice: 'Your orders were successfully updated.'
    else
      render :edit
    end
  end

  private
  def build_grid(orders)
    @grid = PivotTable::Grid.new do |g|
      g.source_data = orders.collect(&:order_items)[0].to_a
      g.column_name = :order_delivery_date
      g.row_name = :product_name
      g.value_name = :quantity
    end

    @grid.build
  end

  def user_params
    params.require(:user).permit!
  end

  def order_params
    params.require(:order).permit!
  end

  def set_products
    @products = Product.all.order_by(:sort_order.asc)
  end

end
