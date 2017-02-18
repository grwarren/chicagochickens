module Responses
  class OrderResponse
    include ActiveAttr::Model

    attribute :user
    validates_presence_of :user

    def orders
      if valid?
        all_orders = []
        delivery_dates.each do |delivery_date|
          users_orders = user.orders.where(delivery_date: delivery_date)
          if users_orders.first.nil?
            order = Order.new(user: user, user_name: user.name, delivery_date: delivery_date)
          else
            order = users_orders.first
          end
          products_for(order).collect { |product|
            OrderItem.new(order:order, product_name: product.name, quantity: 0)
          }
          all_orders += [order]
        end
        all_orders
      else
        []
      end
    end

    private
    def products_for(users_order)
      Product.nin(name: users_order.order_items.map(&:product_name))
    end

    def delivery_dates
      DeliverySchedule.where(:date.gte => Date.today).order_by(:date.asc).limit(2).map(&:date)
    end
  end
end
