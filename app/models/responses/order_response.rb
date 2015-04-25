module Responses
  class OrderResponse
    include ActiveAttr::Model

    attribute :user

    def orders
       users_orders = user.orders.where(delivery_date: delivery_date)

       new_orders = products.collect { | product | Order.new(user: user, product: product, quantity: 0, delivery_date: delivery_date) }
       users_orders + new_orders
    end

    def products
      Product.nin(id: user.orders.map(&:product))
    end

    def delivery_date
      1.week.from_now
    end
  end
end
