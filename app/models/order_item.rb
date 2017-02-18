class OrderItem
  include Comparable
  include Mongoid::Document
  include Mongoid::Timestamps

  field :quantity, type: Integer
  field :product_name, type: String

  embedded_in(:order)

  validates_presence_of  :quantity, :product_name

  def order_delivery_date
    order.delivery_date
  end
end