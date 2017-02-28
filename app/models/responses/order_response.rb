module Responses
  class OrderResponse
    include ActiveAttr::Model

    attribute :user_name
    attribute :delivery_date
    validates_presence_of :user_name, :delivery_date

    def order
      if valid?
        users_orders = Order.and({user_name: user_name, delivery_date: delivery_date})
        if users_orders.size == 0
          order = Order.new(user_name: user_name, delivery_date: delivery_date)
        else
          order = users_orders.first
        end
        products_for(order).collect { |product|
          OrderItem.new(order:order, product_name: product.name, quantity: 0)
        }
        order
      else
        nil
      end
    end

    private
    def products_for(order)
      Product.nin(name: order.order_items.map(&:product_name))
    end

    def delivery_dates
      DeliverySchedule.where(:date.gte => Date.today).order_by(:date.asc).limit(2).map(&:date)
    end
  end
end
