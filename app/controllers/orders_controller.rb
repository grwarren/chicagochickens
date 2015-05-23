class OrdersController < ApplicationController
  before_action :set_current_user
  before_action :set_products, only: [:new, :create]

  def new
    @orders = Responses::OrderResponse.new(user: @current_user).orders
    build_grid(@orders)
  end

   def index_all
    @orders = Order.all.order_by(:delivery_date.desc, :product.asc)
     build_grid(@orders)
   end

  def next_order
    next_delivery_date =  DeliverySchedule.where(:date.gte => Date.today).first().date
    @orders = Order.and({delivery_date:  next_delivery_date}, {quantity: { "$gt" => 0 }}).order_by(:product.asc, :user.asc)
     build_grid(@orders)
  end

  def index
    unless @current_user.nil?
      @orders = @current_user.orders.order_by(:delivery_date.desc, :product.asc)
      build_grid(@orders)
    end

  end

  def create
     params = order_params.merge(user: @current_user)
     order_request = Requests::OrderRequest.new(params: params)
     if order_request.save
       redirect_to user_orders_path(@current_user) , notice: 'Your order has been saved'
     else
       @order = order_request.order
       render :new
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
      g.row_name = :product
      g.value_name = :quantity
    end

    @grid.build
  end

   def user_params
    params.require(:user).permit!
   end

  def order_params
    params.require(:order).permit(:quantity, :delivery_date, :product, :user_name)
  end

  def set_products
    @products = Product.all.order_by(:sort_order.asc)
  end

end
